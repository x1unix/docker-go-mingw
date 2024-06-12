package main

/*
#cgo LDFLAGS: -lkernel32
#include <windows.h>
#include <stdio.h>

// Function to show a MessageBox using WinAPI
void hello() {
  SYSTEM_INFO si;
  ZeroMemory( & si, sizeof(SYSTEM_INFO));
  GetSystemInfo( & si);
  char * arch;
  switch (si.wProcessorArchitecture) {
  case PROCESSOR_ARCHITECTURE_AMD64:
    arch = "AMD64";
    break;
  case PROCESSOR_ARCHITECTURE_INTEL:
    arch = "x86";
    break;
  case PROCESSOR_ARCHITECTURE_ARM:
    arch = "ARM";
    break;
  case PROCESSOR_ARCHITECTURE_ARM64:
    arch = "ARM64";
    break;
  case PROCESSOR_ARCHITECTURE_IA64:
    arch = "IA";
    break;
  default:
    arch = "Unknown";
    break;
  }

  char message[30];
  sprintf(message, "Hello from CGO on %s", arch);

  MessageBox(NULL, message, "Hello World", MB_OK);
}
*/
import "C"
import "fmt"

func main() {
	fmt.Println("Calling C function to open a MessageBox...")
	C.hello()
}
