Return-Path: <virtio-dev-return-8872-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B71F998647C
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Oct 2021 10:13:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
Date: Thu, 14 Oct 2021 12:12:49 +0200
Message-ID: <87o87rvrry.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V9] virtio-gpio: Add support for interrupts
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/114
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V8 -> V9:
> - The patch for base GPIO specification is already merged, sending this
>   separately now.
>
> - Differentiate properly between enabling/disabling and masking/unmasking of the
>   interrupt.
>
> - Specify how a trigger type should be changed, i.e. by disabling interrupt
>   first.
>
> - No fixed sequence for enabling/unmasking of the interrupt, any of them can be
>   done first. The interrupt is only delivered once it is enabled and unmasked.
>
> - Use normative text only in normative sections.
>
> - Guest side Linux driver's IRQ implementation:
>
>   https://lore.kernel.org/linux-gpio/96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org/
>
>  conformance.tex |   2 +
>  virtio-gpio.tex | 248 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 249 insertions(+), 1 deletion(-)

(...)

> diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> index 3c614ec97b92..fba7ec400bb3 100644
> --- a/virtio-gpio.tex
> +++ b/virtio-gpio.tex
> @@ -11,11 +11,17 @@ \subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
>  
>  \begin{description}
>  \item[0] requestq
> +\item[1] eventq
>  \end{description}
>  
> +The \field{eventq} virtqueue is available only if the \field{VIRTIO_GPIO_F_IRQ}
> +feature is enabled by the device.
> +
>  \subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
>  
> -None currently defined.
> +\begin{description}
> +\item[VIRTIO_GPIO_F_IRQ (0)] The device supports interrupts on GPIO lines.
> +\end{description}
>  
>  \subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
>  
> @@ -46,6 +52,14 @@ \subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device
>  
>  \begin{itemize}
>  \item The driver configures and initializes the \field{requestq} virtqueue.
> +
> +\item The driver checks the presence of \field{VIRTIO_GPIO_F_IRQ} feature
> +    before initiating any IRQ related messages.
> +
> +\item The driver configures and initializes the \field{eventq} virtqueue.
> +
> +\item The device configures all GPIO lines in \field{VIRTIO_GPIO_IRQ_TYPE_NONE}
> +    trigger type state.

As the interrupt stuff depends on the feature bit, this probably should
look more like

- If VIRTIO_GPIO_F_IRQ has been negotiated:
  * The driver configures and initializes the eventq virtqueue.
(Not sure where "initiating any IRQ related messages" fits in; isn't
that more something that happens during operation?)

What triggers the device to configure the GPIO lines in that state? Is
that something that it should already do when it decides to offer the
feature bit?

>  \end{itemize}
>  
>  \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / requestq Operation}

(...)

> @@ -313,6 +404,20 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
>  
>  \item The driver MAY send multiple messages for same or different GPIO lines in
>      parallel.
> +
> +\item The driver MUST NOT send IRQ messages if the \field{VIRTIO_GPIO_F_IRQ}
> +    feature is not enabled by the device.

s/is not enabled by the device/has not been negotiated/

> +
> +\item The driver MUST NOT send IRQ messages for a GPIO line configured for
> +    output.
> +
> +\item The driver MUST set the IRQ trigger type to
> +    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line
> +    configured for interrupts.
> +
> +\item In order to change the trigger type of an already enabled interrupt, the
> +    driver MUST first disable the interrupt and then re-enable it with
> +    appropriate trigger type.
>  \end{itemize}
>  
>  \devicenormative{\subsubsection}{requestq Operation}{Device Types / GPIO Device / requestq Operation}

(...)

> +\devicenormative{\subsubsection}{eventq Operation}{Device Types / GPIO Device / eventq Operation}
> +
> +\begin{itemize}
> +\item The device CAN ONLY send an interrupt event to the driver for a GPIO line,
> +    if the interrupt is both unmasked and enabled by the driver.

"The device MUST NOT send an interrupt event to the driver for a GPIO
line unless the interrupt has been both unmasked and enabled by the
driver." ?

> +
> +\item On receiving \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message, with
> +    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} trigger type, the device MUST return the
> +    buffers, if they were received earlier, after setting the \field{status}
> +    field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}.
>  \end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

