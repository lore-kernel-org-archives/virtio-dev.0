Return-Path: <virtio-dev-return-11291-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB976C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:15:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1BBD02B055
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:15:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7229986784
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:15:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D34AE98413F; Sat, 25 Feb 2023 23:15:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1FAA9866B0
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 23:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BH6hSniEPQSL1dTklAFd7Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iEIrrsS7u0YfKZgoJBiarXcf0H1NNpODCN5Wdn09lA=;
        b=lrnCV83c2ZsWEpsJX2pn0WmO07WRCXvSDnP8JD+Zgf4mvxvyh84fVr1lOTscCg0DJM
         CRwI5DPih7vfXTxeh55VzSS7txzYIzpSUkadLdJCTZln7UvM4M5EIGLChb0qhtEC0LiF
         UKyEE0LA2v8WrEjtLBoouBYNdUmnDg6QtrLuY+YfXzRCr3UIw6eWhRdr6UCEUtwozxpI
         HD7GxU1YDll/ru3h1BGJOGxyDbSbORGWkiAbl6ladBNiyepwMxWcBprWo4spvL63PGYC
         fOmtM/VqKPh6XI4axcKeQe1wAATjE79anCTHWxmuhvDI3yjIr94aukEPXdydmTz14ukJ
         7C2A==
X-Gm-Message-State: AO0yUKVE/BAFSRMexBn2RdfOm9/8FrDwnaznHkmz10i1MjPyOS2RDYu8
	Mzexk3gCnaTxpw2FCO1v4vWoE2FI9dcAahLx7Bf1vTVmfo6ENzhIxQLyd7KNJmUokQb+t7IC6/y
	Xu1rVZs33FlRVCrlXXhPDPg8Y8sb7
X-Received: by 2002:a5d:6502:0:b0:2c5:fb6d:33e5 with SMTP id x2-20020a5d6502000000b002c5fb6d33e5mr16691696wru.0.1677366914024;
        Sat, 25 Feb 2023 15:15:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9v12hZvZt1nbMExX0U1PpH/UjDctEqxpq3Yf8YATo0ZjtlYu4aLbO9s703iC0EBAZA4Pgk9A==
X-Received: by 2002:a5d:6502:0:b0:2c5:fb6d:33e5 with SMTP id x2-20020a5d6502000000b002c5fb6d33e5mr16691692wru.0.1677366913595;
        Sat, 25 Feb 2023 15:15:13 -0800 (PST)
Date: Sat, 25 Feb 2023 18:15:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225180932-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225223001.430522-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Message-ID: <20230225231509.xqSkHxPD0YJJG6txuMSQnUDaZsA_NVwOF_0rU4pVII4@z>

On Sun, Feb 26, 2023 at 12:30:00AM +0200, Parav Pandit wrote:
> Currently single legacy interface section describes PCI common
> configuration layout and feature bits operation for the
> legacy interface.
> Secondly common configuration structure description of legacy interface
> is not adjacent to the the respective normal device requirements for
> same.
> 
> Hence, split PCI Device Layout legacy interface section into two
> parts. First subsection for common configuration and second
> subsection for feature bits.
> 
> Subsequent patch relocates common configuration legacy interface to
> appropriate matching location.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I don't care really. However this does much more than move text around
as it claim to do:


> ---
>  conformance.tex   |  4 +++-
>  transport-pci.tex | 19 ++++++++++++-------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..0d3616f 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -262,7 +262,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
>  \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
> +configuration Layout}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 9ee37ba..9d4c713 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -767,7 +767,10 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>  specified by some other Virtio Structure PCI Capability
>  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>  
> -\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> +\subsubsection{Legacy Interfaces: A Note on Common configuration
> +Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
> +/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
> +configuration Layout}
>  
>  The transitional device MUST present part of the configuration
>  registers in a legacy configuration structure in BAR0 in the


Please do not split up labels to multiple lines like this, it is hard to
find and fix them if you do.

> @@ -852,13 +855,15 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
>  is encoded in the native endian of the guest (where such
>  distinction is applicable).
>  
> -When accessing the device-specific configuration structure
> -using the legacy interface, transitional drivers MUST access
> -the device-specific configuration structure
> -at an offset immediately following the legacy common
> -configuration structure.
> +The transitional driver when using the legacy interface MUST
> +the device-specific configuration structure at an offset
> +immediately following the legacy common configuration structure.

Oh great and in the process of presumably just moving stuff around you
are also losing text - the result is agrammatical, and much less clear
than the original.


>  
> -Note that only Feature Bits 0 to 31 are accessible through the
> +\subsubsection{Legacy Interface: A Note on feature
> +bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> +Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
> +
> +Only Feature Bits 0 to 31 are accessible through the
>  Legacy Interface. When used through the Legacy Interface,
>  the transitional device MUST assume that Feature Bits 32 to 63
>  are not acknowledged by the driver.

And you are dropping "Note" here because why? Seems notable
in that there are more feature bits, someone might miss this
fact.




> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

