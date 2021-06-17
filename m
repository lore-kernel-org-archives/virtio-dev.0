Return-Path: virtio-comment-return-1906-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 17 Jun 2021 17:03:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
References: <20210617094122.1627-1-info@metux.net>
 <20210617094122.1627-2-info@metux.net>
MIME-Version: 1.0
In-Reply-To: <20210617094122.1627-2-info@metux.net>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-gpio: add formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

+ couple of folks who have shown interest in this stuff.

On 17-06-21, 11:41, Enrico Weigelt, metux IT consult wrote:
> This patch adds specification for attaching general purpose IO (gpio) devices
> via virtio. The protocol is specifically designed to be easily implemented in
> software (e.g. hypervisors) as well as low end hardware (eg. silicon, FPGA,
> tiny MCUs) and allows future extensions while retaining full backwards
> compatibility.
> 
> Implementations for driver (Linux kernel) and device (Qemu) are publically
> available and field tested since late 2020. Hardware implementations also
> exist (but proprietary, cannot be published yet).
> 
> Device type ID 41 has been allocated by TC vote #3632.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  conformance.tex |  28 +++++-
>  content.tex     |   3 +
>  virtio-gpio.tex | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-gpio.tex

FWIW ./makehtml.sh reported a few missing references I believe, it
wasn't a clean build.

> diff --git a/conformance.tex b/conformance.tex
> index a164cbb..e5956f4 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / General Purpose IO Driver Conformance}.
>  
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> -\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance} or
> +\ref{sec:Conformance / Device Conformance / General Purpose IO Device Conformance}.
>  
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -288,6 +290,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
>  \end{itemize}
>  
> +\conformance{\subsection}{General Purpose IO Driver Conformance}\label{sec:Conformance / Driver Conformance / General Purpose IO Driver Conformance}
> +
> +An General Purpose IO driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / General Purpose IO / Virtqueues}
> +\item \ref{devicenormative:Device Types / General Purpose IO / Data flow}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>  
>  A device MUST conform to the following normative statements:
> @@ -527,6 +538,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / SCMI Device / Device Operation / Shared Memory Operation}
>  \end{itemize}
>  
> +\conformance{\subsection}{General Purpose IO Device Conformance}\label{sec:Conformance / Device Conformance / General Purpose IO Device Conformance}
> +
> +An General Purpose IO device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / General Purpose IO / Virtqueues}
> +\item \ref{devicenormative:Device Types / General Purpose IO / Data flow}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index 90685fc..3e9d1a1 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2876,6 +2876,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  40         &   Bluetooth device \\
>  \hline
> +41         &   General Purpose IO device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> @@ -6581,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-mem.tex}
>  \input{virtio-i2c.tex}
>  \input{virtio-scmi.tex}
> +\input{virtio-gpio.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> new file mode 100644
> index 0000000..6ab0307
> --- /dev/null
> +++ b/virtio-gpio.tex
> @@ -0,0 +1,259 @@
> +\section{General Purpose IO Device}\label{sec:Device Types / General Purpose IO}
> +
> +The virtio gpio device is a general purpose IO device that supports a variable
> +number of named IO lines that may be switched either as input or output and
> +in logical level 0 or 1.
> +
> +\subsection{Device ID}\label{sec:Device Types / General Purpose IO / Device ID}
> +  41
> +
> +\subsection{Version}\label{sec:Device Types / General Purpose IO / Version}
> +  1
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / General Purpose IO / Device configuration layout}
> +
> +General purpose IO configuration uses the following layout structure:
> +
> +\begin{tabular}{|l|l|l|}
> +    \hline
> +    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
> +    \hline
> +    0x00   & u8           & version \\

As previously mentioned by Jason as well, most of the virtio protocol
specifications don't talk about versions but rather Features. The
features are normally more readable than saying version is 1.0 or 2.0.

This is a standard used by Virtio specification so we should reuse
that instead of creating protocol specific versions.

> +    0x02   & u16 LE       & number of GPIO lines \\
> +    0x04   & u32 LE       & size of gpio name block \\
> +    0x20   & char$[$32$]$ & device name (0-terminated) \\
> +    0x40   & char$[$$]$   & line names block \\

I understand from our previous discussions that you wanted to make it
possible for this structure to be extended in the future and so kept
the extra padding of 24 bytes. That is a right thing to do, as we may
need to add more fields here.

Having said that, the only thing which limits this structure to be
extended in future is the "line names block", simply because we don't
know the size of it in advance and we need to keep it at the end for
the same reason.

A better approach for that, as Jean Philippe suggested earlier, is to
rather add a new field, "gpio names offset", which will convey the
offset of the names block from the beginning of the structure. In your
case you can keep it to 0x40, while others can avoid the rather
unnecessary padding.

You may think today that 24 bytes of padding or reserved fields would
be sufficient for ever, but that may not be true. The requirements
change all the time and we shouldn't limit the possibility of
extension here, as you have earlier said.


> +    \hline
> +\end{tabular}
> +
> +\begin{itemize}
> +    \item for \field{version} field currently only value 1 supported.
> +    \item the \field{line names block} holds a stream of zero-terminated strings,
> +        containing the individual line names in ASCII. line names must unique.
> +    \item unspecified fields are reserved for future use and should be zero.
> +    \item future versions may extend this configuration space by additional fields.
> +\end{itemize}
> +
> +\subsection{Virtqueues}\label{sec:Device Types / General Purpose IO / Virtqueues}
> +\begin{description}
> +\item[0] rx (device to CPU)

What is CPU here? Driver/Guest ? I wonder if it would be better if we
talk in terms of Virtio spec standards here, which are "device" and
"driver".

> +\item[1] tx (CPU to device)
> +\end{description}
> +
> +The virtqueues transport messages of the type struct virtio_gpio_msg from device to CPU or CPU to device.
> +
> +\subsubsection{Virtqueues}\label{sec:Device Types / General Purpose IO / Virtqueues / Message format}
> +
> +The queues transport messages of the struct virtio_gpio_msg:
> +
> +\begin{tabular}{|l|l|l|}
> +    \hline
> +    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
> +    \hline
> +    0x00   & uint16 LE & message type  \\
> +    0x02   & uint16 LE & line id       \\
> +    0x04   & uint32 LE & value         \\
> +    \hline
> +\end{tabular}

It would be fine to have same format for request and response in our
use case.

> +
> +\subsubsection{Message types}\label{sec:Device Types / General Purpose IO / Virtqueues / Message types}
> +
> +\begin{tabular}{|l|ll|}
> +    \hline
> +    \textbf{Code} & \textbf{Symbol} & \\
> +    \hline
> +    0x0001        & VIRTIO_GPIO_MSG_CPU_REQUEST            & request gpio line           \\

This requires a corresponding "FREE" Msg type as well. This is already
well implemented and accepted in Linux kernel as well.

> +    0x0002        & VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT    & set direction to input      \\
> +    0x0003        & VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT   & set direction to output     \\
> +    0x0004        & VIRTIO_GPIO_MSG_CPU_GET_DIRECTION      & read current direction      \\
> +    0x0005        & VIRTIO_GPIO_MSG_CPU_GET_LEVEL          & read current level          \\
> +    0x0006        & VIRTIO_GPIO_MSG_CPU_SET_LEVEL          & set current (out) level     \\

These look good.

> +    0x0011        & VIRTIO_GPIO_MSG_DEVICE_LEVEL           & level changed (device->CPU) \\

I believe this is the interrupt from Device to Driver ? I believe it
would be more readable if it can be called as an interrupt.

I do not see a way for masking/unmasking interrupts right now, we need
them right now. I am fine with adding other request types, like
debounce, etc, later on, but interrupt support is bare minimum for us.
These are the new request types we would need for that, unless there
are more:

IRQ_TYPE	IRQ_MASK	IRQ_UNMASK

And these are the interrupt types we need to support, for now. Again
they are quite standard if you look at Linux's GPIO support.

IRQ_TYPE_NONE	
IRQ_TYPE_EDGE_RISING
IRQ_TYPE_EDGE_FALLING	
IRQ_TYPE_EDGE_BOTH	
IRQ_TYPE_LEVEL_HIGH	
IRQ_TYPE_LEVEL_LOW	

> +    \hline
> +    0x8000        & VIRTIO_GPIO_MSG_REPLY                  & device reply mask           \\
> +    \hline
> +\end{tabular}
> +
> +\devicenormative{\subsubsection}{Virtqueues}{Device Types / General Purpose IO / Virtqueues}
> +
> +The device MUST read from the tx queue and write to rx queue.
> +
> +The device MUST NOT write to the tx queue.
> +
> +\drivernormative{\subsubsection}{Virtqueues}{Device Types / General Purpose IO / Virtqueues}
> +
> +The device MUST read from the rx queue and write to tx queue.

s/device/driver/ ?

> +
> +The device MUST NOT write to the rx queue.

Same.

> +
> +\subsection{Data flow}\label{sec:Device Types / General Purpose IO / Data flow}
> +
> +\begin{itemize}
> +    \item all operations, except \field{VIRTIO_GPIO_MSG_DEVICE_LEVEL}, are initiated by CPU (tx queue)
> +    \item device replies with the orinal \field{type} value OR'ed with \field{VIRTIO_GPIO_MSG_REPLY} (rx queue)

original*

> +    \item requests are processed and replied in the they had been sent

in the *order* they...

Why is this important really ? If there are constraints in the control
flow (i.e. operation 1 must happen before operation 2), then the
request initiator needs to make sure of that. Otherwise, it doesn't
matter which one finishes first. The response message will have the
GPIO number in it and so the initiator will know whose response it is.

While on that, we must put a limit on number of messages started by
one side for the same GPIO line. i.e. Driver can not start another
operation for the same GPIO line, before receiving response for the
previous request for that GPIO line. Same goes for interrupts from
device to driver/CPU.

> +    \item async notifications by the device may be interleaved with request responses
> +    \item VIRTIO_GPIO_MSG_DEVICE_LEVEL is only sent asynchronously from device to CPU
> +    \item in replies, a negative \field{value} field denotes an Unix-style / POSIX errno code
> +    \item the actual error values \textit{(despite being negative or not)} is only of informational
> +          nature -- a device or vm host \textit{may} report more detailed error cause but is not required to.
> +    \item valid direction values are: 0 = output, 1 = input
> +    \item valid line level values are: 0 = inactive, 1 = active
> +    \item CPU should not send messages with unspecified \field{type} value
> +    \item CPU should ignore ignore messages with unspecified \field{type} value

double "ignore".

> +\end{itemize}
> +
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_REQUEST}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_REQUEST}
> +
> +Notify the device that given line number is going to be used.
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} & \\
> +    \hline
> +    \field{line}  field: & logical line number \\

s/logical/GPIO/ ?

> +    \field{value} field: & unused (should be zero) \\

Missing \hline here.

> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & POSIX errno code (0 = success, non-zero = error) \\
> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT}
> +
> +Set line line direction to input.
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & unused (should be zero) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & POSIX errno code (0 = success, non-zero = error) \\
> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT}
> +
> +Set line direction to output and given line level.
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & output level (0=inactive, 1=active) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & POSIX errno code (0 = success, non-zero = error) \\
> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_GET_DIRECTION}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_GET_DIRECTION}
> +
> +Retrieve line direction.
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} & \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & unused (should be zero) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & direction (0=output, 1=input) or POSIX errno code \\
> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_GET_LEVEL}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_GET_LEVEL}
> +
> +Retrieve line level.
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} & \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & unused (should be zero) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & line level (0=inactive, 1=active) or errno code \\
> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_CPU_SET_LEVEL}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_SET_LEVEL}
> +
> +Set line level (output only)
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} & \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & line level (0=inactive, 1=active) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \hline
> +    \field{value} field: & new line level or (negative) POSIX errno code \\

Why not 0 for success? How will the driver use the returned value here ?

> +    \hline
> +\end{tabular}
> +
> +\subsubsection{VIRTIO_GPIO_MSG_DEVICE_LEVEL}\label{sec:Device Types / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_DEVICE_LEVEL}
> +
> +Async notification from device to CPU: line level changed
> +
> +\begin{tabular}{ll}
> +    \hline
> +    \textbf{request:} & \\
> +    \hline
> +    \field{line}  field: & logical line number \\
> +    \field{value} field: & unused (should be zero) \\
> +    \hline
> +    \textbf{reply:} & \\
> +    \field{value} field: & line level (0=inactive, 1=active) \\
> +    \hline
> +\end{tabular}
> +
> +\devicenormative{\subsubsection}{Data flow}{Device Types / General Purpose IO / Data flow}
> +
> +The device MUST reply to all driver requests in they had been sent.
> +
> +The device MUST copy the \field{line} field from the request to its reply.
> +
> +Except for async notification, the device MUST reply the orignal message type, but with the highest bit set
> +(or'ed with VIRTIO_GPIO_MSG_REPLY)
> +
> +In case of error the device MUST fill an negative value into the \field{value} field, it SHOULD use
> +an fitting POSIX / Unix errno value when applicable.
> +
> +On switching to output, the device SHOULD set internal output level before switching the line to output.
> +
> +The device SHOULD send VIRTIO_GPIO_MSG_DEVICE_LEVEL message for a particular line when it is in input
> +direction and line level changes.
> +
> +\drivernormative{\subsubsection}{Data flow}{Device Types / General Purpose IO / Data flow}
> +
> +The driver MUST NOT send VIRTIO_GPIO_MSG_DEVICE_LEVEL and MUST NOT set the highest bit in the message type.

The device would need some kind of acknowledgement (as Linus also
asked earlier) for the interrupt from the driver, before which it is
eligible to send another interrupt for the same line.

> +
> +The driver MUST NOT send messages with types not defined in this specification.
> +
> +\subsection{Future versions}\label{sec:Device Types / General Purpose IO / Future versions}
> +
> +\begin{itemize}
> +    \item future versions must increment the ``version`` value
> +    \item the basic data structures (config space, message format) should remain
> +          backwards compatible, but may increased in size or use reserved fields
> +    \item device needs to support commands in older versions
> +    \item CPU should not send commands of newer versions that the device doesn't support
> +\end{itemize}
> +
> +\subsection{Feature bits}\label{sec:Device Types / General Purpose IO / Feature bits}
> +
> +There are currently no feature bits defined for this device, but may be added in future versions.

And yes please use a feature for adding IRQ support, as you previously
said some of the implementations may not define it.

Thanks.

-- 
viresh

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

