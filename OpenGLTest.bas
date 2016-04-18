    #COMPILE EXE
    #DIM ALL
    #INCLUDE "win32api.inc"
    #INCLUDE "gl.inc"
    #INCLUDE "glu.inc"
    GLOBAL hDlg, hDC, hRC AS DWORD

    FUNCTION PBMAIN() AS LONG
      DIALOG NEW PIXELS, 0, "OpenGL Example",,, 320, 240, _
                               %WS_OVERLAPPEDWINDOW TO hDlg
      DIALOG SHOW MODAL hdlg CALL dlgproc
    END FUNCTION

    CALLBACK FUNCTION dlgproc()
       SELECT CASE CB.MSG
          CASE %WM_INITDIALOG
              GetRenderContext
              InitializeScene
          CASE %WM_SIZE
              ResizeScene LO(WORD, CB.LPARAM), HI(WORD, CB.LPARAM)
              DrawScene
          CASE %WM_PAINT
              DrawScene
          CASE %WM_CLOSE
              wglmakecurrent %null, %null 'unselect rendering context
              wgldeletecontext hRC        'delete the rendering context
       END SELECT
    END FUNCTION

    SUB GetRenderContext
       LOCAL pfd AS PIXELFORMATDESCRIPTOR, fmt AS LONG
       pfd.nSize       =  SIZEOF(PIXELFORMATDESCRIPTOR)
       pfd.nVersion    =  1
       pfd.dwFlags     = %pfd_draw_to_window OR _
                         %pfd_support_opengl OR %pfd_doublebuffer
       pfd.dwlayermask = %pfd_main_plane
       pfd.iPixelType  = %pfd_type_rgba
       pfd.ccolorbits  = 24
       pfd.cdepthbits  = 24

       hDC = GetDC(hDlg)                 'DC for dialog
       fmt = ChoosePixelFormat(hDC, pfd) 'set device context properties
       SetPixelFormat(hDC, fmt, pfd)     'set properties of device context
       hRC = wglCreateContext (hDC)      'get rendering context
       wglMakeCurrent hDC, hRC           'make the RC current
    END SUB

    SUB InitializeScene
       glClearColor 0,0,0,0   'color to be used with glClear
       glClearDepth 1         'zvalue to be used with glClear
    END SUB

    SUB ResizeScene (w AS LONG, h AS LONG)
       glViewport 0, 0, w, h             'resize viewport
       glMatrixMode %gl_projection       'select projection matrix
       glLoadIdentity                    'reset projection matrix
       gluPerspective 45, w/h, 0.1, 100  'set perspective aspect ratio
       glMatrixMode %gl_modelview        'select modelview matrix
    END SUB

    SUB DrawScene
       glClear %gl_color_buffer_bit OR %gl_depth_buffer_bit
       glLoadIdentity               'clear the modelview matrix
       glBegin %gl_triangles        'select triangles as primitive
          glcolor3ub 255,0,0        'set default vertex color
          glvertex3f  0, 1,  -4     'vertex1
          glvertex3f  -1, 0, -4     'vertex2
          glvertex3f  1, -1, -4     'vertex3
       glEnd
       SwapBuffers hDC              'display the buffer (image)
    END SUB
