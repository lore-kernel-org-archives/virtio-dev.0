Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1634037711.git.viresh.kumar@linaro.org> <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
In-Reply-To: <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 12 Oct 2021 16:09:41 +0200
Message-ID: <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12, 2021 at 1:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/112
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

I have a few very minor comments, regardless of how you address those:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> index 5d634aec6e7c..0e73348963ce 100644
> --- a/virtio-i2c.tex
> +++ b/virtio-i2c.tex
> @@ -17,7 +17,11 @@ \subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Virtqueues
>
>  \subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / Feature bits}
>
> -None currently defined.
> +\begin{description}
> +\item[VIRTIO_I2C_F_ZERO_LENGTH_REQUEST (0)] The device supports zero-length I2C
> +request and \field{VIRTIO_I2C_FLAGS_M_RD} flag. It is mandatory to implement
> +this feature.
> +\end{description}

I'm not quite sure what it means to have a mandatory feature flag,
or what the driver is expected to do if it finds the flag to be missing.

Assuming this is something we do in other virtio specs, I see nothing
wrong here though.

> @@ -99,6 +106,15 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
>  #define VIRTIO_I2C_MSG_ERR    1
>  \end{lstlisting}
>
> +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
> +request is called a read request.
> +
> +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
> +request is called a write request.
> +
> +The \field{buf} is optional and will not be present for a zero-length request,
> +like SMBus Quick.

Maybe write this as

... like the SMBus "Quick" command.

> @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>
> +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.

I don't think this needs to be "SHOULD", as a driver may be written to only
talk to certain i2c clients on the device side, and they do not need zero
length requests. Maybe this could be

"A driver MAY assume that the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST
feature is available".

> @@ -141,6 +167,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>
> +A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.

On the device side it seems reasonable.

         Arnd

