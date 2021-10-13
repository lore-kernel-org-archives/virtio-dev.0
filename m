Return-Path: <virtio-dev-return-8862-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBAB498640D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Oct 2021 09:26:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
Date: Wed, 13 Oct 2021 11:26:14 +0200
Message-ID: <87bl3twa15.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The I2C protocol allows zero-length requests with no data, like the
> SMBus Quick command, where the command is inferred based on the
> read/write flag itself.
>
> In order to allow such a request, allocate another bit,
> VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
> or write. This was earlier done using the read/write permission to the
> buffer itself.
>
> Add a new feature flag for zero length requests and make it mandatory
> for it to be implemented, so we don't need to drag the old
> implementation around.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/112
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  virtio-i2c.tex | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
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

Maybe add a footnote, explaining that VIRTIO_I2C_FLAGS_M_RD had not been
specified initially, and that we need an easy way to detect incompatible
implementations?

> +\end{description}
>  
>  \subsection{Device configuration layout}\label{sec:Device Types / I2C Adapter Device / Device configuration layout}
>  

(...)

> @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>  
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>  
> +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.

Make this MUST, or maybe "MUST accept"? The central point of the feature
flag (at least for me) was to be able to change the semantics and format
without things breaking silently. I don't think we need to keep old
driver revisions compliant?

> +
>  A driver MUST set \field{addr} and \field{flags} before sending the request.
>  
>  A driver MUST set the reserved bits of \field{flags} to be zero.
>  
> +A driver MUST NOT send the \field{buf}, for a zero-length request.
> +
>  A driver MUST NOT use \field{buf}, for a read request, if the final
>  \field{status} returned from the device is VIRTIO_I2C_MSG_ERR.
>  
> +A driver MUST set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a read operation,
> +where the buffer is write-only for the device.
> +
> +A driver MUST NOT set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a write
> +operation, where the buffer is read-only for the device.
> +
>  A driver MUST queue the requests in order if multiple requests are going to
>  be sent at a time.
>  
> @@ -141,6 +167,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>  
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>  
> +A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.

Same here, I would make this "MUST offer", and simply make old device
implementations non-compliant. The device should also reject any driver
that does not negotiate the flag, I think?

> +
>  A device SHOULD keep consistent behaviors with the hardware as described in
>  \hyperref[intro:I2C]{I2C}.
>  

No objections from my side to the reset of the changes.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

