Return-Path: <virtio-dev-return-11290-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9843AC64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:08:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E1B332B064
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:08:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0965986790
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:08:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A595B9866A9; Sat, 25 Feb 2023 23:08:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93BF89866B0
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 23:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0iAzJmCUOkC_U4WlMdIAQg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htWjR4ucVS2IZxqKiPFa6isJuqD47rsuhRRuWTd8J4A=;
        b=j3/UyE7ztVrGmHKdeGadAafuRjowpnkpET1CS54Gxx4CXovthsvP3VZjiRg9ka9FR2
         Ku6OpPVVYl0CZSz7PY4rYFNIss85dCAegJh9Xb7E2xPzoZkrWJnvNn6E7AEioW3HD/Wz
         CrGLEkIA685ZMGqBGZtaD1L1tNUCMXali6F9LhndknYnc5sSDb1F9ImFjDEr9AEzA4Gd
         sY1Hd15gxTpDARzN+c62mGBG5s8DU5wOwpQG2DwGTbvG2fz2wZf/BfmDywEPSDr0Z4kG
         amPvH5CvavAPEaNjWcUiVA57P0Z/G6QK4IIMdaO0ZUst+vij1dVScfGoKq7EeekxBZu0
         v8Vg==
X-Gm-Message-State: AO0yUKXAj9iHkn5M7QeNMxPpDyA21OCqrF4XlPxfxYNP6qa4YOotI9xq
	cMcsQ7BJtWYYkWnnXT8AsQeFg5Tg6XlipByUL3a46HuYeZPM0wgfKWTUKLxmc6tdJYA6cN1B0y5
	ig6qj1waDRRaxIHYeHwl7Ww8aa+DF
X-Received: by 2002:a05:600c:1895:b0:3e2:f80:3df1 with SMTP id x21-20020a05600c189500b003e20f803df1mr15322448wmp.19.1677366527930;
        Sat, 25 Feb 2023 15:08:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/dNio/VsThEYM5cHMmAwDSMBQRoTavicuA3ssl68rm6XYSkJ6jfyn5GU6YCTxaQweoeO0bMg==
X-Received: by 2002:a05:600c:1895:b0:3e2:f80:3df1 with SMTP id x21-20020a05600c189500b003e20f803df1mr15322441wmp.19.1677366527509;
        Sat, 25 Feb 2023 15:08:47 -0800 (PST)
Date: Sat, 25 Feb 2023 18:08:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225180014-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225223001.430522-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/3] transport-pci: Improve PCI legacy device layout
 description
Message-ID: <20230225230843.6Si9bZXnDJJZag_Ur1A90Z1tZ0XQa281dMQJOZZ62RE@z>

On Sun, Feb 26, 2023 at 12:29:59AM +0200, Parav Pandit wrote:
> Legacy interface PCI Device layout description has following issues.
> 
> 1. repeated 'structure' word
> 2. virtio header was defined the 0.9.5 spec. In a legacy interface
>    section it is referred with different keywards
>    as (a) virtio header, (b) general headers, (c) legacy configuration
>    structure, (d) virtio common configuration structure and
>    (e) other fields.
> 3. Driver and device requirements listing is intermixed.
> 4. spelling error of structure
> 
> Hence, rewrite the description to eliminate above issues as below.
> 
> 1. Removed repeated structure word
> 2. Fix spelling of structure
> 3. Place all device requirements toegether
> 3. Define legacy configuration structure that consist of
>    a. legacy common configuration structure and
>    b. device specific configuration structure
> 4. Rewrite section around above changes
> 
> This is only an editorial change.

No, editorial changes are things like spelling corrections.

I have trouble reviewing
because I have no idea why you are making each change.

E.g. you just rewrote a bunch of text and I frankly don't know
why. For example:

	-When using the legacy interface, transitional drivers
	-MUST use the legacy configuration structure in BAR0 in the first
	-I/O region of the PCI device, as documented below.

is now apparently:

	+When used through the legacy interface, the legacy common
	+configuration structure has the following layout:

and this is better? why? we are replacing a clear requirement
which applied to drivers with a vague statement which
I can't say what it applies to.

Any chance of splitting these things up? Maybe that will help.

Apropos I don't know that we want to spend much time on legacy sections.
Really with legacy code is the main source of documentation -
if drivers work then you are golden. If they don't appealing
to spec will not help.



> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 93 ++++++++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 5d22e6f..9ee37ba 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -769,25 +769,19 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>  
>  \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>  
> -Transitional devices MUST present part of configuration
> -registers in a legacy configuration structure in BAR0 in the first I/O
> -region of the PCI device, as documented below.
> -When using the legacy interface, transitional drivers
> -MUST use the legacy configuration structure in BAR0 in the first
> -I/O region of the PCI device, as documented below.
> -
> -When using the legacy interface the driver MAY access
> -the device-specific configuration region using any width accesses, and
> -a transitional device MUST present driver with the same results as
> -when accessed using the ``natural'' access method (i.e.
> -32-bit accesses for 32-bit fields, etc).
> -
> -Note that this is possible because while the virtio common configuration structure is PCI
> -(i.e. little) endian, when using the legacy interface the device-specific
> -configuration region is encoded in the native endian of the guest (where such distinction is
> -applicable).
> -
> -When used through the legacy interface, the virtio common configuration structure looks as follows:
> +The transitional device MUST present part of the configuration
> +registers in a legacy configuration structure in BAR0 in the
> +first I/O region of the PCI Device.
> +
> +The legacy configuration structure is described below.
> +It consists of two parts.
> +\begin{enumerate}
> +  \item Legacy common configuration structure
> +  \item Device configuration structure (optional)
> +\end{enumerate}
> +
> +When used through the legacy interface, the legacy common
> +configuration structure has the following layout:
>  
>  \begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
>  \hline
> @@ -801,8 +795,8 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
>  \hline
>  \end{tabularx}
>  
> -If MSI-X is enabled for the device, two additional fields
> -immediately follow this header:
> +When MSI-X capability is enabled on the device, the device MUST
> +present two additional fields immediately following the above fields:
>  
>  \begin{tabular}{ |l||l|l| }
>  \hline
> @@ -814,14 +808,12 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
>  \hline
>  \end{tabular}
>  
> -Note: When MSI-X capability is enabled, device-specific configuration starts at
> -byte offset 24 in virtio common configuration structure structure. When MSI-X capability is not
> -enabled, device-specific configuration starts at byte offset 20 in virtio
> -header.  ie. once you enable MSI-X on the device, the other fields move.
> -If you turn it off again, they move back!
> +The device configuration structure is optional. Its existence
> +is decided by each device type. The transitional device MUST
> +present the device-specific configuration structure if any at an
> +offset immediately following the legacy common configuration structure.
>  
> -Any device-specific configuration space immediately follows
> -these general headers:
> +The device configuration structure:
>  
>  \begin{tabular}{|l||l|l|}
>  \hline
> @@ -833,25 +825,44 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
>  \hline
>  \end{tabular}
>  
> -When accessing the device-specific configuration space
> -using the legacy interface, transitional
> -drivers MUST access the device-specific configuration space
> -at an offset immediately following the general headers.
> -
> -When using the legacy interface, transitional
> -devices MUST present the device-specific configuration space
> -if any at an offset immediately following the general headers.
> -
> -Note that only Feature Bits 0 to 31 are accessible through the
> -Legacy Interface. When used through the Legacy Interface,
> -Transitional Devices MUST assume that Feature Bits 32 to 63
> -are not acknowledged by Driver.
> +Note: The device configuration structure byte offset is
> +calculated dynamically; when MSI-X capability is enabled, the
> +device configuration structure is located at byte offset 24,
> +when MSI-X capability is disabled, the device configuration
> +structure is located at byte offset 20.
>  
>  As legacy devices had no \field{config_generation} field,
>  see \ref{sec:Basic Facilities of a Virtio Device / Device
>  Configuration Space / Legacy Interface: Device Configuration
>  Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
>  
> +When using the legacy interface, the transitional driver MUST
> +use the legacy configuration structure in BAR0 in the first
> +I/O region of the PCI device.
> +
> +When using the legacy interface, the driver MAY access
> +the device-specific configuration structure using any width
> +accesses and the transitional device MUST present the driver with
> +the same results as when accessed using the ``natural'' access
> +method (i.e. 32-bit accesses for 32-bit fields, etc).
> +
> +Note that this is possible because while the legacy common
> +configuration structure is PCI (i.e. little) endian, when using
> +the legacy interface the device-specific configuration structure
> +is encoded in the native endian of the guest (where such
> +distinction is applicable).
> +
> +When accessing the device-specific configuration structure
> +using the legacy interface, transitional drivers MUST access
> +the device-specific configuration structure
> +at an offset immediately following the legacy common
> +configuration structure.
> +
> +Note that only Feature Bits 0 to 31 are accessible through the
> +Legacy Interface. When used through the Legacy Interface,
> +the transitional device MUST assume that Feature Bits 32 to 63
> +are not acknowledged by the driver.
> +
>  \subsubsection{Non-transitional Device With Legacy Driver: A Note
>  on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
>  Over PCI Bus / PCI Device Layout / Non-transitional Device With
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

