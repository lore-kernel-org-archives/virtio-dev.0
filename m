Return-Path: <virtio-dev-return-9071-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00886986423
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jan 2022 15:39:54 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220114225032.290762-1-mst@redhat.com>
References: <20220114225032.290762-1-mst@redhat.com>
Date: Mon, 17 Jan 2022 16:39:32 +0100
Message-ID: <87k0eyv0az.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> We state that drivers can access config fields before FEATURES_OK. We do
> however need them to write the features before accessing config
> otherwise our forward compatibility won't work.
>
> We require devices to allow access to config space if they
> offer a feature bit as long as that has been offered, but
> this can't work of course since we don't know what value
> does driver expect. What we should have said is "as long
> as it has been acknowledged".
>
> While at it, clarify that drivers can write features
> repeatedly as long as FEATURES_OK have note been
> acknowledged.
>
> Note: if device denies FEATURES_OK then there's no reason
> not to allow the driver to try with another set of features.
> Current drivers do not need such a capability, so leave this
> idea for another day.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 8439cc1..4f46ce9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,10 +298,10 @@ \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Devi
>  \end{note}
>  
>  \devicenormative{\subsection}{Device Configuration Space}{Basic Facilities of a Virtio Device / Device Configuration Space}
> -The device MUST allow reading of any device-specific configuration
> +The device SHOULD allow reading of any device-specific configuration

Why 'SHOULD'? I think the device MUST allow it for features that have
already been written by the driver, given that is always a subset of the
features that have been offered by the device.

Maybe "The device MUST allow reading of any device-specific
configuration field that is not depending on a feature bit, and any
device-specific configuration field that is conditional on a feature bit
that has been written back by the driver, before FEATURES_OK is set by
the driver. It MAY allow reading of any other configuration field."

>  field before FEATURES_OK is set by the driver.  This includes fields which are
> -conditional on feature bits, as long as those feature bits are offered
> -by the device.
> +conditional on feature bits, as long as those feature bits have
> +been acknowledged by the driver.

Better 'written back'? To me, 'acknowledged' carries overtones of
'negotiated', and that is not meaningful before FEATURES_OK.

>  
>  \subsection{Legacy Interface: A Note on Device Configuration Space endian-ness}\label{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: A Note on Configuration Space endian-ness}
>  
> @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
>  
>  \item\label{itm:General Initialization And Device Operation /
>  Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
> -   understood by the OS and driver to the device.  During this step the
> -   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
> +   understood by the OS and driver to the device.  During this
> +   step, after writing the subset of feature bits to the device the
> +   driver MAY read (but MUST NOT write) the device-specific
> +   configuration fields to validate that it can support the device
> +   before accepting it. The driver MAY then repeatedly modify the
> +   subset as appropriate, write the new subset and repeat the
> +   validation, any number of times.
>  
>  \item\label{itm:General Initialization And Device Operation / Device Initialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver MUST NOT accept
>     new feature bits after this step.
> @@ -3296,6 +3301,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  \field{duplex} fields as long as VIRTIO_NET_S_LINK_UP is set in
>  the \field{status}.
>  
> +If the device offers VIRTIO_NET_F_MTU, the device SHOULD allow
> +reading of \field{mtu} before FEATURES_OK is set by the driver
> +even if VIRTIO_NET_F_MTU has not been acknowledged by the driver.
> +This is to support existing drivers which access this field
> +before acknowledging features.

Maybe better 'written back', see my comment above.

Also note this in the patch description?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

