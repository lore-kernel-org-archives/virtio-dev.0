Return-Path: <virtio-comment-return-3608-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 24 Dec 2022 20:06:17 +0200
Message-ID: <20221224180619.73959-5-parav@nvidia.com>
In-Reply-To: <20221224180619.73959-1-parav@nvidia.com>
References: <20221224180619.73959-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 4/6] virtio-console: Maintain console device spec in separate file
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio console device specification to its own file similar to
recent virtio devices.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 content.tex        | 233 +--------------------------------------------
 virtio-console.tex | 233 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 232 deletions(-)
 create mode 100644 virtio-console.tex

diff --git a/content.tex b/content.tex
index f0e5fe0..0a25765 100644
--- a/content.tex
+++ b/content.tex
@@ -5912,238 +5912,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device Types /
=20
 See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Fr=
aming}.
=20
-\section{Console Device}\label{sec:Device Types / Console Device}
-
-The virtio console device is a simple device for data input and
-output. A device MAY have one or more ports. Each port has a pair
-of input and output virtqueues. Moreover, a device has a pair of
-control IO virtqueues. The control virtqueues are used to
-communicate information between the device and the driver about
-ports being opened and closed on either side of the connection,
-indication from the device about whether a particular port is a
-console port, adding new ports, port hot-plug/unplug, etc., and
-indication from the driver about whether a port or a device was
-successfully added, port open/close, etc. For data IO, one or
-more empty buffers are placed in the receive queue for incoming
-data and outgoing characters are placed in the transmit queue.
-
-\subsection{Device ID}\label{sec:Device Types / Console Device / Device ID=
}
-
-  3
-
-\subsection{Virtqueues}\label{sec:Device Types / Console Device / Virtqueu=
es}
-
-\begin{description}
-\item[0] receiveq(port0)
-\item[1] transmitq(port0)
-\item[2] control receiveq
-\item[3] control transmitq
-\item[4] receiveq(port1)
-\item[5] transmitq(port1)
-\item[\ldots]
-\end{description}
-
-The port 0 receive and transmit queues always exist: other queues
-only exist if VIRTIO_CONSOLE_F_MULTIPORT is set.
-
-\subsection{Feature bits}\label{sec:Device Types / Console Device / Featur=
e bits}
-
-\begin{description}
-\item[VIRTIO_CONSOLE_F_SIZE (0)] Configuration \field{cols} and \field{row=
s}
-    are valid.
-
-\item[VIRTIO_CONSOLE_F_MULTIPORT (1)] Device has support for multiple
-    ports; \field{max_nr_ports} is valid and control virtqueues will be us=
ed.
-
-\item[VIRTIO_CONSOLE_F_EMERG_WRITE (2)] Device has support for emergency w=
rite.
-    Configuration field emerg_wr is valid.
-\end{description}
-
-\subsection{Device configuration layout}\label{sec:Device Types / Console =
Device / Device configuration layout}
-
-  The size of the console is supplied
-  in the configuration space if the VIRTIO_CONSOLE_F_SIZE feature
-  is set. Furthermore, if the VIRTIO_CONSOLE_F_MULTIPORT feature
-  is set, the maximum number of ports supported by the device can
-  be fetched.
-
-  If VIRTIO_CONSOLE_F_EMERG_WRITE is set then the driver can use emergency=
 write
-  to output a single character without initializing virtio queues, or even
-  acknowledging the feature.
-
-\begin{lstlisting}
-struct virtio_console_config {
-        le16 cols;
-        le16 rows;
-        le32 max_nr_ports;
-        le32 emerg_wr;
-};
-\end{lstlisting}
-
-\subsubsection{Legacy Interface: Device configuration layout}\label{sec:De=
vice Types / Console Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
-When using the legacy interface, transitional devices and drivers
-MUST format the fields in struct virtio_console_config
-according to the native endian of the guest rather than
-(necessarily when not using the legacy interface) little-endian.
-
-\subsection{Device Initialization}\label{sec:Device Types / Console Device=
 / Device Initialization}
-
-\begin{enumerate}
-\item If the VIRTIO_CONSOLE_F_EMERG_WRITE feature is offered,
-  \field{emerg_wr} field of the configuration can be written at any time.
-  Thus it works for very early boot debugging output as well as
-  catastophic OS failures (eg. virtio ring corruption).
-
-\item If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, the driver
-  can read the console dimensions from \field{cols} and \field{rows}.
-
-\item If the VIRTIO_CONSOLE_F_MULTIPORT feature is negotiated, the
-  driver can spawn multiple ports, not all of which are necessarily
-  attached to a console. Some could be generic ports. In this
-  case, the control virtqueues are enabled and according to
-  \field{max_nr_ports}, the appropriate number
-  of virtqueues are created. A control message indicating the
-  driver is ready is sent to the device. The device can then send
-  control messages for adding new ports to the device. After
-  creating and initializing each port, a
-  VIRTIO_CONSOLE_PORT_READY control message is sent to the device
-  for that port so the device can let the driver know of any additional
-  configuration options set for that port.
-
-\item The receiveq for each port is populated with one or more
-  receive buffers.
-\end{enumerate}
-
-\devicenormative{\subsubsection}{Device Initialization}{Device Types / Con=
sole Device / Device Initialization}
-
-The device MUST allow a write to \field{emerg_wr}, even on an
-unconfigured device.
-
-The device SHOULD transmit the lower byte written to \field{emerg_wr} to
-an appropriate log or output method.
-
-\subsection{Device Operation}\label{sec:Device Types / Console Device / De=
vice Operation}
-
-\begin{enumerate}
-\item For output, a buffer containing the characters is placed in
-  the port's transmitq\footnote{Because this is high importance and low ba=
ndwidth, the current
-Linux implementation polls for the buffer to become used, rather than
-waiting for a used buffer notification, simplifying the implementation
-significantly. However, for generic serial ports with the
-O_NONBLOCK flag set, the polling limitation is relaxed and the
-consumed buffers are freed upon the next write or poll call or
-when a port is closed or hot-unplugged.
-}.
-
-\item When a buffer is used in the receiveq (signalled by a
-  used buffer notification), the contents is the input to the port associa=
ted
-  with the virtqueue for which the notification was received.
-
-\item If the driver negotiated the VIRTIO_CONSOLE_F_SIZE feature, a
-  configuration change notification indicates that the updated size can
-  be read from the configuration fields.  This size applies to port 0 only=
.
-
-\item If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT
-  feature, active ports are announced by the device using the
-  VIRTIO_CONSOLE_PORT_ADD control message. The same message is
-  used for port hot-plug as well.
-\end{enumerate}
-
-\drivernormative{\subsubsection}{Device Operation}{Device Types / Console =
Device / Device Operation}
-
-The driver MUST NOT put a device-readable buffer in a receiveq. The driver
-MUST NOT put a device-writable buffer in a transmitq.
-
-\subsubsection{Multiport Device Operation}\label{sec:Device Types / Consol=
e Device / Device Operation / Multiport Device Operation}
-
-If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT, the two
-control queues are used to manipulate the different console ports: the
-control receiveq for messages from the device to the driver, and the
-control sendq for driver-to-device messages.  The layout of the
-control messages is:
-
-\begin{lstlisting}
-struct virtio_console_control {
-        le32 id;    /* Port number */
-        le16 event; /* The kind of control event */
-        le16 value; /* Extra information for the event */
-};
-\end{lstlisting}
-
-The values for \field{event} are:
-\begin{description}
-\item [VIRTIO_CONSOLE_DEVICE_READY (0)] Sent by the driver at initializati=
on
-  to indicate that it is ready to receive control messages.  A value of
-  1 indicates success, and 0 indicates failure.  The port number \field{id=
} is unused.
-\item [VIRTIO_CONSOLE_DEVICE_ADD (1)] Sent by the device, to create a new
-  port.  \field{value} is unused.
-\item [VIRTIO_CONSOLE_DEVICE_REMOVE (2)] Sent by the device, to remove an
-  existing port. \field{value} is unused.
-\item [VIRTIO_CONSOLE_PORT_READY (3)] Sent by the driver in response
-  to the device's VIRTIO_CONSOLE_PORT_ADD message, to indicate that
-  the port is ready to be used. A \field{value} of 1 indicates success, an=
d 0
-  indicates failure.
-\item [VIRTIO_CONSOLE_CONSOLE_PORT (4)] Sent by the device to nominate
-  a port as a console port.  There MAY be more than one console port.
-\item [VIRTIO_CONSOLE_RESIZE (5)] Sent by the device to indicate
-  a console size change.  \field{value} is unused.  The buffer is followed=
 by the number of columns and rows:
-\begin{lstlisting}
-struct virtio_console_resize {
-        le16 cols;
-        le16 rows;
-};
-\end{lstlisting}
-\item [VIRTIO_CONSOLE_PORT_OPEN (6)] This message is sent by both the
-  device and the driver.  \field{value} indicates the state: 0 (port
-  closed) or 1 (port open).  This allows for ports to be used directly
-  by guest and host processes to communicate in an application-defined
-  manner.
-\item [VIRTIO_CONSOLE_PORT_NAME (7)] Sent by the device to give a tag
-  to the port.  This control command is immediately
-  followed by the UTF-8 name of the port for identification
-  within the guest (without a NUL terminator).
-\end{description}
-
-\devicenormative{\paragraph}{Multiport Device Operation}{Device Types / Co=
nsole Device / Device Operation / Multiport Device Operation}
-
-The device MUST NOT specify a port which exists in a
-VIRTIO_CONSOLE_DEVICE_ADD message, nor a port which is equal or
-greater than \field{max_nr_ports}.
-
-The device MUST NOT specify a port in VIRTIO_CONSOLE_DEVICE_REMOVE
-which has not been created with a previous VIRTIO_CONSOLE_DEVICE_ADD.
-
-\drivernormative{\paragraph}{Multiport Device Operation}{Device Types / Co=
nsole Device / Device Operation / Multiport Device Operation}
-
-The driver MUST send a VIRTIO_CONSOLE_DEVICE_READY message if
-VIRTIO_CONSOLE_F_MULTIPORT is negotiated.
-
-Upon receipt of a VIRTIO_CONSOLE_CONSOLE_PORT message, the driver
-SHOULD treat the port in a manner suitable for text console access
-and MUST respond with a VIRTIO_CONSOLE_PORT_OPEN message, which MUST
-have \field{value} set to 1.
-
-\subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types =
/ Console Device / Device Operation / Legacy Interface: Device Operation}
-When using the legacy interface, transitional devices and drivers
-MUST format the fields in struct virtio_console_control
-according to the native endian of the guest rather than
-(necessarily when not using the legacy interface) little-endian.
-
-When using the legacy interface, the driver SHOULD ignore the
-used length values for the transmit queues
-and the control transmitq.
-\begin{note}
-Historically, some devices put the total descriptor length there,
-even though no data was actually written.
-\end{note}
-
-\subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
-Types / Console Device / Legacy Interface: Framing Requirements}
-
-When using legacy interfaces, transitional drivers which have not
-negotiated VIRTIO_F_ANY_LAYOUT MUST use only a single
-descriptor for all buffers in the control receiveq and control transmitq.
-
+\input{virtio-console.tex}
 \input{virtio-entropy.tex}
 \input{virtio-mem-balloon.tex}
 \input{virtio-scsi.tex}
diff --git a/virtio-console.tex b/virtio-console.tex
new file mode 100644
index 0000000..b7e89cd
--- /dev/null
+++ b/virtio-console.tex
@@ -0,0 +1,233 @@
+\section{Console Device}\label{sec:Device Types / Console Device}
+
+The virtio console device is a simple device for data input and
+output. A device MAY have one or more ports. Each port has a pair
+of input and output virtqueues. Moreover, a device has a pair of
+control IO virtqueues. The control virtqueues are used to
+communicate information between the device and the driver about
+ports being opened and closed on either side of the connection,
+indication from the device about whether a particular port is a
+console port, adding new ports, port hot-plug/unplug, etc., and
+indication from the driver about whether a port or a device was
+successfully added, port open/close, etc. For data IO, one or
+more empty buffers are placed in the receive queue for incoming
+data and outgoing characters are placed in the transmit queue.
+
+\subsection{Device ID}\label{sec:Device Types / Console Device / Device ID=
}
+
+  3
+
+\subsection{Virtqueues}\label{sec:Device Types / Console Device / Virtqueu=
es}
+
+\begin{description}
+\item[0] receiveq(port0)
+\item[1] transmitq(port0)
+\item[2] control receiveq
+\item[3] control transmitq
+\item[4] receiveq(port1)
+\item[5] transmitq(port1)
+\item[\ldots]
+\end{description}
+
+The port 0 receive and transmit queues always exist: other queues
+only exist if VIRTIO_CONSOLE_F_MULTIPORT is set.
+
+\subsection{Feature bits}\label{sec:Device Types / Console Device / Featur=
e bits}
+
+\begin{description}
+\item[VIRTIO_CONSOLE_F_SIZE (0)] Configuration \field{cols} and \field{row=
s}
+    are valid.
+
+\item[VIRTIO_CONSOLE_F_MULTIPORT (1)] Device has support for multiple
+    ports; \field{max_nr_ports} is valid and control virtqueues will be us=
ed.
+
+\item[VIRTIO_CONSOLE_F_EMERG_WRITE (2)] Device has support for emergency w=
rite.
+    Configuration field emerg_wr is valid.
+\end{description}
+
+\subsection{Device configuration layout}\label{sec:Device Types / Console =
Device / Device configuration layout}
+
+  The size of the console is supplied
+  in the configuration space if the VIRTIO_CONSOLE_F_SIZE feature
+  is set. Furthermore, if the VIRTIO_CONSOLE_F_MULTIPORT feature
+  is set, the maximum number of ports supported by the device can
+  be fetched.
+
+  If VIRTIO_CONSOLE_F_EMERG_WRITE is set then the driver can use emergency=
 write
+  to output a single character without initializing virtio queues, or even
+  acknowledging the feature.
+
+\begin{lstlisting}
+struct virtio_console_config {
+        le16 cols;
+        le16 rows;
+        le32 max_nr_ports;
+        le32 emerg_wr;
+};
+\end{lstlisting}
+
+\subsubsection{Legacy Interface: Device configuration layout}\label{sec:De=
vice Types / Console Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
+When using the legacy interface, transitional devices and drivers
+MUST format the fields in struct virtio_console_config
+according to the native endian of the guest rather than
+(necessarily when not using the legacy interface) little-endian.
+
+\subsection{Device Initialization}\label{sec:Device Types / Console Device=
 / Device Initialization}
+
+\begin{enumerate}
+\item If the VIRTIO_CONSOLE_F_EMERG_WRITE feature is offered,
+  \field{emerg_wr} field of the configuration can be written at any time.
+  Thus it works for very early boot debugging output as well as
+  catastophic OS failures (eg. virtio ring corruption).
+
+\item If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, the driver
+  can read the console dimensions from \field{cols} and \field{rows}.
+
+\item If the VIRTIO_CONSOLE_F_MULTIPORT feature is negotiated, the
+  driver can spawn multiple ports, not all of which are necessarily
+  attached to a console. Some could be generic ports. In this
+  case, the control virtqueues are enabled and according to
+  \field{max_nr_ports}, the appropriate number
+  of virtqueues are created. A control message indicating the
+  driver is ready is sent to the device. The device can then send
+  control messages for adding new ports to the device. After
+  creating and initializing each port, a
+  VIRTIO_CONSOLE_PORT_READY control message is sent to the device
+  for that port so the device can let the driver know of any additional
+  configuration options set for that port.
+
+\item The receiveq for each port is populated with one or more
+  receive buffers.
+\end{enumerate}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / Con=
sole Device / Device Initialization}
+
+The device MUST allow a write to \field{emerg_wr}, even on an
+unconfigured device.
+
+The device SHOULD transmit the lower byte written to \field{emerg_wr} to
+an appropriate log or output method.
+
+\subsection{Device Operation}\label{sec:Device Types / Console Device / De=
vice Operation}
+
+\begin{enumerate}
+\item For output, a buffer containing the characters is placed in
+  the port's transmitq\footnote{Because this is high importance and low ba=
ndwidth, the current
+Linux implementation polls for the buffer to become used, rather than
+waiting for a used buffer notification, simplifying the implementation
+significantly. However, for generic serial ports with the
+O_NONBLOCK flag set, the polling limitation is relaxed and the
+consumed buffers are freed upon the next write or poll call or
+when a port is closed or hot-unplugged.
+}.
+
+\item When a buffer is used in the receiveq (signalled by a
+  used buffer notification), the contents is the input to the port associa=
ted
+  with the virtqueue for which the notification was received.
+
+\item If the driver negotiated the VIRTIO_CONSOLE_F_SIZE feature, a
+  configuration change notification indicates that the updated size can
+  be read from the configuration fields.  This size applies to port 0 only=
.
+
+\item If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT
+  feature, active ports are announced by the device using the
+  VIRTIO_CONSOLE_PORT_ADD control message. The same message is
+  used for port hot-plug as well.
+\end{enumerate}
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / Console =
Device / Device Operation}
+
+The driver MUST NOT put a device-readable buffer in a receiveq. The driver
+MUST NOT put a device-writable buffer in a transmitq.
+
+\subsubsection{Multiport Device Operation}\label{sec:Device Types / Consol=
e Device / Device Operation / Multiport Device Operation}
+
+If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT, the two
+control queues are used to manipulate the different console ports: the
+control receiveq for messages from the device to the driver, and the
+control sendq for driver-to-device messages.  The layout of the
+control messages is:
+
+\begin{lstlisting}
+struct virtio_console_control {
+        le32 id;    /* Port number */
+        le16 event; /* The kind of control event */
+        le16 value; /* Extra information for the event */
+};
+\end{lstlisting}
+
+The values for \field{event} are:
+\begin{description}
+\item [VIRTIO_CONSOLE_DEVICE_READY (0)] Sent by the driver at initializati=
on
+  to indicate that it is ready to receive control messages.  A value of
+  1 indicates success, and 0 indicates failure.  The port number \field{id=
} is unused.
+\item [VIRTIO_CONSOLE_DEVICE_ADD (1)] Sent by the device, to create a new
+  port.  \field{value} is unused.
+\item [VIRTIO_CONSOLE_DEVICE_REMOVE (2)] Sent by the device, to remove an
+  existing port. \field{value} is unused.
+\item [VIRTIO_CONSOLE_PORT_READY (3)] Sent by the driver in response
+  to the device's VIRTIO_CONSOLE_PORT_ADD message, to indicate that
+  the port is ready to be used. A \field{value} of 1 indicates success, an=
d 0
+  indicates failure.
+\item [VIRTIO_CONSOLE_CONSOLE_PORT (4)] Sent by the device to nominate
+  a port as a console port.  There MAY be more than one console port.
+\item [VIRTIO_CONSOLE_RESIZE (5)] Sent by the device to indicate
+  a console size change.  \field{value} is unused.  The buffer is followed=
 by the number of columns and rows:
+\begin{lstlisting}
+struct virtio_console_resize {
+        le16 cols;
+        le16 rows;
+};
+\end{lstlisting}
+\item [VIRTIO_CONSOLE_PORT_OPEN (6)] This message is sent by both the
+  device and the driver.  \field{value} indicates the state: 0 (port
+  closed) or 1 (port open).  This allows for ports to be used directly
+  by guest and host processes to communicate in an application-defined
+  manner.
+\item [VIRTIO_CONSOLE_PORT_NAME (7)] Sent by the device to give a tag
+  to the port.  This control command is immediately
+  followed by the UTF-8 name of the port for identification
+  within the guest (without a NUL terminator).
+\end{description}
+
+\devicenormative{\paragraph}{Multiport Device Operation}{Device Types / Co=
nsole Device / Device Operation / Multiport Device Operation}
+
+The device MUST NOT specify a port which exists in a
+VIRTIO_CONSOLE_DEVICE_ADD message, nor a port which is equal or
+greater than \field{max_nr_ports}.
+
+The device MUST NOT specify a port in VIRTIO_CONSOLE_DEVICE_REMOVE
+which has not been created with a previous VIRTIO_CONSOLE_DEVICE_ADD.
+
+\drivernormative{\paragraph}{Multiport Device Operation}{Device Types / Co=
nsole Device / Device Operation / Multiport Device Operation}
+
+The driver MUST send a VIRTIO_CONSOLE_DEVICE_READY message if
+VIRTIO_CONSOLE_F_MULTIPORT is negotiated.
+
+Upon receipt of a VIRTIO_CONSOLE_CONSOLE_PORT message, the driver
+SHOULD treat the port in a manner suitable for text console access
+and MUST respond with a VIRTIO_CONSOLE_PORT_OPEN message, which MUST
+have \field{value} set to 1.
+
+\subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types =
/ Console Device / Device Operation / Legacy Interface: Device Operation}
+When using the legacy interface, transitional devices and drivers
+MUST format the fields in struct virtio_console_control
+according to the native endian of the guest rather than
+(necessarily when not using the legacy interface) little-endian.
+
+When using the legacy interface, the driver SHOULD ignore the
+used length values for the transmit queues
+and the control transmitq.
+\begin{note}
+Historically, some devices put the total descriptor length there,
+even though no data was actually written.
+\end{note}
+
+\subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
+Types / Console Device / Legacy Interface: Framing Requirements}
+
+When using legacy interfaces, transitional drivers which have not
+negotiated VIRTIO_F_ANY_LAYOUT MUST use only a single
+descriptor for all buffers in the control receiveq and control transmitq.
+
+
--=20
2.26.2


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

