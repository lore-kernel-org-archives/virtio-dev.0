Return-Path: <virtio-dev-return-8506-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BFE0986551
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Aug 2021 16:03:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <3e801cbef0a46d5c4f82d46debd3a72811becd4c.1627627021.git.viresh.kumar@linaro.org>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <3e801cbef0a46d5c4f82d46debd3a72811becd4c.1627627021.git.viresh.kumar@linaro.org>
Date: Fri, 06 Aug 2021 18:02:52 +0200
Message-ID: <87lf5ey30z.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V8 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 30 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
> communicate with the host GPIO controllers from the guest.
>
> Note that the current implementation doesn't provide atomic APIs for
> GPIO configurations. i.e. the driver (guest) would need to implement
> sleep-able versions of the APIs as the guest will respond asynchronously
> over the virtqueue.
>
> This patch adds the specification for it.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  conformance.tex |  28 +++-
>  content.tex     |   1 +
>  virtio-gpio.tex | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-gpio.tex

Sorry for being late, but I do have a few minor nits from a spec standpoint.

>
> diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> new file mode 100644
> index 000000000000..1d1ac672db37
> --- /dev/null
> +++ b/virtio-gpio.tex
> @@ -0,0 +1,346 @@
> +\section{GPIO Device}\label{sec:Device Types / GPIO Device}
> +
> +The Virtio GPIO device is a virtual General Purpose Input/Output device that
> +supports a variable number of named I/O lines, which can be configured in input
> +mode or in output mode with logical level low (0) or high (1).
> +
> +\subsection{Device ID}\label{sec:Device Types / GPIO Device / Device ID}
> +41
> +
> +\subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
> +
> +None currently defined.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
> +
> +GPIO device uses the following configuration structure layout:
> +
> +\begin{lstlisting}
> +struct virtio_gpio_config {
> +    le16 ngpio;
> +    u8 padding[2];
> +    le32 gpio_names_size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{ngpio}] is the total number of GPIO lines supported by the device.
> +
> +\item[\field{padding}] has no meaning and is reserved for future use. This
> +    MUST be set to zero by the device.

This is not a conformance section, so you can't use 'MUST'. Maybe "This
is set to zero by the device." ? If it is a hard requirement, it might
need a conformance entry.

> +
> +\item[\field{gpio_names_size}] is the size of the gpio-names memory block in
> +    bytes, which can be fetched by the driver using the
> +    \field{VIRTIO_GPIO_MSG_GET_LINE_NAMES} message. The device MUST set this to
> +    0 if it doesn't support names for the GPIO lines.

Same here.

> +\end{description}
> +
> +
> +\subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device Initialization}
> +
> +\begin{itemize}
> +\item The driver MUST configure and initialize the \field{requestq} virtqueue.

Also outside of conformance sections. Maybe "The driver configures and
initializes..." ? I don't think that one requires a normative statement.

> +\end{itemize}
> +
> +\subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / requestq Operation}
> +
> +The driver uses the \field{requestq} virtqueue to send messages to the device.
> +The driver sends a pair of buffers, request (filled by driver) and response (to
> +be filled by device later), to the device. The device in turn fills the response
> +buffer and sends it back to the driver.
> +
> +\begin{lstlisting}
> +struct virtio_gpio_request {
> +    le16 type;
> +    le16 gpio;
> +    le32 value;
> +};
> +\end{lstlisting}
> +
> +All the fields of this structure are set by the driver and read by the device.
> +
> +\begin{description}
> +\item[\field{type}] is the GPIO message type, i.e. one of
> +    \field{VIRTIO_GPIO_MSG_*} values.
> +
> +\item[\field{gpio}] is the GPIO line number, i.e. 0 <= \field{gpio} <
> +    \field{ngpio}.
> +
> +\item[\field{value}] is a message specific value.
> +\end{description}
> +
> +\begin{lstlisting}
> +struct virtio_gpio_response {
> +    u8 status;
> +    u8 value;
> +};
> +
> +/* Possible values of the status field */
> +#define VIRTIO_GPIO_STATUS_OK                   0x0
> +#define VIRTIO_GPIO_STATUS_ERR                  0x1
> +\end{lstlisting}
> +
> +All the fields of this structure are set by the device and read by the driver.
> +
> +\begin{description}
> +\item[\field{status}] of the GPIO message,
> +    \field{VIRTIO_GPIO_STATUS_OK} on success and \field{VIRTIO_GPIO_STATUS_ERR}
> +    on failure.
> +
> +\item[\field{value}] is a message specific value.
> +\end{description}
> +
> +Following is the list of messages supported by the virtio gpio specification.
> +
> +\begin{lstlisting}
> +/* GPIO message types */
> +#define VIRTIO_GPIO_MSG_GET_LINE_NAMES          0x0001
> +#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0002
> +#define VIRTIO_GPIO_MSG_SET_DIRECTION           0x0003
> +#define VIRTIO_GPIO_MSG_GET_VALUE               0x0004
> +#define VIRTIO_GPIO_MSG_SET_VALUE               0x0005
> +
> +/* GPIO Direction types */
> +#define VIRTIO_GPIO_DIRECTION_NONE              0x00
> +#define VIRTIO_GPIO_DIRECTION_OUT               0x01
> +#define VIRTIO_GPIO_DIRECTION_IN                0x02
> +\end{lstlisting}
> +
> +\subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Line Names}
> +
> +The driver sends this message to receive a stream of zero-terminated strings,
> +where each string represents the name of a GPIO line, present in increasing
> +order of the GPIO line numbers. The names of the GPIO lines are optional and may
> +be present only for a subset of GPIO lines. If missing, then a zero-byte must be
> +present for the GPIO line. If present, the name string must be zero-terminated
> +and the name must be unique within a GPIO Device.
> +
> +These names of the GPIO lines should be most meaningful producer names for the
> +system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
> +and "ethernet reset" are reasonable line names as they describe what the line is
> +used for, while "GPIO0" is not a good name to give to a GPIO line.
> +
> +Here is an example of how the gpio names memory block may look like for a GPIO
> +device with 10 GPIO lines, where line names are provided only for lines 0
> +("MMC-CD"), 5 ("Red LED Vdd") and 7 ("ethernet reset").
> +
> +\begin{lstlisting}
> +u8 gpio_names[] = {
> +    'M', 'M', 'C', '-', 'C', 'D', 0,
> +    0,
> +    0,
> +    0,
> +    0,
> +    'R', 'e', 'd', ' ', 'L', 'E', 'D', ' ', 'V', 'd', 'd', 0,
> +    0,
> +    'E', 't', 'h', 'e', 'r', 'n', 'e', 't', ' ', 'r', 'e', 's', 'e', 't', 0,
> +    0,
> +    0
> +};
> +\end{lstlisting}
> +
> +The device MUST set the \field{gpio_names_size} to a non-zero value if this
> +message is supported by the device, else it must be set to zero.

This should move to the conformance section.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

