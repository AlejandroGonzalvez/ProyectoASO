import queue
import platform

try:
    if platform.system() == "Windows":
        import win32print
    elif platform.system() == "Linux" or platform.system() == "Darwin":
        import cups
except ImportError:
    pass

class PrintJob:
    def __init__(self, job_id, file_name, printer):
        self.job_id = job_id
        self.file_name = file_name
        self.printer = printer

    def __str__(self):
        return f"Job {self.job_id}: {self.file_name} -> {self.printer}"

class PrintManager:
    def __init__(self):
        self.printers = []  # Lista de impresoras disponibles
        self.job_queue = queue.Queue()  # Cola de impresión
        self.job_id_counter = 1
        self.detect_default_printer()

    def detect_default_printer(self):
        """Detecta la impresora predeterminada del sistema y la agrega."""
        default_printer = None
        if platform.system() == "Windows":
            default_printer = win32print.GetDefaultPrinter()
        elif platform.system() == "Linux" or platform.system() == "Darwin":
            conn = cups.Connection()
            default_printer = conn.getDefault()
        
        if default_printer:
            self.add_printer(default_printer)
            print(f"Impresora predeterminada detectada: {default_printer}")

    def add_printer(self, printer_name):
        """Agrega una impresora disponible."""
        if printer_name not in self.printers:
            self.printers.append(printer_name)
            print(f"Impresora '{printer_name}' añadida.")
        else:
            print("La impresora ya está registrada.")

    def list_printers(self):
        """Muestra las impresoras disponibles."""
        if not self.printers:
            print("No hay impresoras disponibles.")
        else:
            print("Impresoras disponibles:")
            for printer in self.printers:
                print(f"- {printer}")

    def add_print_job(self, file_name, printer):
        """Añade un trabajo a la cola de impresión."""
        if printer not in self.printers:
            print("Error: La impresora no está disponible.")
            return
        job = PrintJob(self.job_id_counter, file_name, printer)
        self.job_queue.put(job)
        print(f"Trabajo de impresión añadido: {job}")
        self.job_id_counter += 1

    def list_jobs(self):
        """Muestra la lista de trabajos en la cola de impresión."""
        if self.job_queue.empty():
            print("No hay trabajos en cola.")
        else:
            print("Trabajos en cola:")
            for job in list(self.job_queue.queue):
                print(job)

    def cancel_job(self, job_id):
        """Cancela un trabajo de impresión por ID."""
        temp_queue = queue.Queue()
        found = False

        while not self.job_queue.empty():
            job = self.job_queue.get()
            if job.job_id == job_id:
                print(f"Trabajo {job_id} cancelado.")
                found = True
            else:
                temp_queue.put(job)

        self.job_queue = temp_queue

        if not found:
            print("Trabajo no encontrado.")

# Ejemplo de uso
if __name__ == "__main__":
    manager = PrintManager()
    manager.list_printers()
    manager.add_print_job("documento.pdf", manager.printers[0] if manager.printers else "")
    manager.add_print_job("foto.jpg", manager.printers[0] if manager.printers else "")
    manager.list_jobs()
    manager.cancel_job(1)
    manager.list_jobs()
