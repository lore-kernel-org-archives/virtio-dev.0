Return-Path: <virtio-dev-return-12718-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B56DC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 10:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A4612370E6
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 10:05:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 970DC986514
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 10:05:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8282B983E4A; Tue, 16 May 2023 10:05:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F1DA986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 10:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: N0Gy_fR5PfyaSnSt-BkVuQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231532; x=1686823532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzeDLcuPBoCC4gkvoGr3MZLYnDNpwZIQSPPAtfmdPpo=;
        b=kk9aCeSHC1MjYhF+Lsph3v0sWcLMeRNpSaEXukBNoSSxXkOqv6N86Eg7pqqkYfQsxH
         ndJD8p9JEEjuGn/1fFMNDpDQL0KLrvKuVe+fbE+8HP4xteW3nA/NGck+eUVW8U7iKSDc
         BeSEEZPHkGQN0S/6/rNfmRAyzzrcsWm6J5IU/IoyQJ0HBhK7bw6EhDFMEZo0LUcaDu5R
         PWodXbwcudb5FqfndkdZ+1pseZnEiwdTfH6PFCwFnKD2TeCxI4zll0jz26erdmRggB+F
         Ycc/hdqBhWGTTIf8hkHL8Jy+UMRECdsUbFucBrhzjY2/0Y16k9Gz9c0e1Vn15XogOgWj
         ox/w==
X-Gm-Message-State: AC+VfDyyrbSZ70affXgEIY19hcHzi+4M8w2zEbiyYZYaI+RBiGHVM6bt
	SetWmptCoKf9FAOQcF/BB33n/56VdLj/+dUz4QDuieeylxkrqnKSbHYVL7+nGPlm+F8Kz53OCYP
	VoF4yLXmjyFzpzVNMIkOxkN5pdEml
X-Received: by 2002:a17:907:3203:b0:94a:8f3a:1a77 with SMTP id xg3-20020a170907320300b0094a8f3a1a77mr32720043ejb.8.1684231531810;
        Tue, 16 May 2023 03:05:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ft958Gfj3yDH9+9vUnnFFCnNpwss3th+MTY1qBCAc7447xuxReLdcoXw6t6i/futZsUIXVA==
X-Received: by 2002:a17:907:3203:b0:94a:8f3a:1a77 with SMTP id xg3-20020a170907320300b0094a8f3a1a77mr32720028ejb.8.1684231531429;
        Tue, 16 May 2023 03:05:31 -0700 (PDT)
Date: Tue, 16 May 2023 06:05:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230516054313-mutt-send-email-mst@kernel.org>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org>
 <87lehohefn.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87lehohefn.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] content: Replace guest OS with driver

On Tue, May 16, 2023 at 10:24:12AM +0200, Cornelia Huck wrote:
> On Tue, May 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, May 16, 2023 at 06:01:39AM +0300, Parav Pandit wrote:
> >> diff --git a/content.tex b/content.tex
> >> index 9df81b8..417d476 100644
> >> --- a/content.tex
> >> +++ b/content.tex
> >> @@ -26,10 +26,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
> >>  following bits are defined (listed below in the order in which
> >>  they would be typically set):
> >>  \begin{description}
> >> -\item[ACKNOWLEDGE (1)] Indicates that the guest OS has found the
> >> +\item[ACKNOWLEDGE (1)] Indicates that the driver has found the
> >>    device and recognized it as a valid virtio device.
> >>  
> >> -\item[DRIVER (2)] Indicates that the guest OS knows how to drive the
> >> +\item[DRIVER (2)] Indicates that the driver knows how to drive the
> >>    device.
> >>    \begin{note}
> >>      There could be a significant (or infinite) delay before setting
> >
> > Actually, there is a subtle difference here that this is losing.
> > "guest OS" really refers to e.g. Linux virtio core code here.
> >
> >
> > ACKNOWLEDGE and DRIVER are used by virtio core.
> >
> > ACKNOWLEDGE tells you virtio core attached to device, and DRIVER
> > tells you core found a device specific driver.
> >
> >
> >
> > If you really want to make things better, let's find a way to explain
> > all this.
> 
> Agreed, this is a really old part of the spec, and likely had been
> written with the Linux device probing sequence in mind.
> 
> Basically, we want to distinguish between "something on the driver side
> has discovered the device" and "something on the driver side knows how
> to drive this specific device". If we consider "driver" as a catch-all
> of the whole thing talking to a device, we need to be extra descriptive
> (and we can add examples, as this is a non-normative section.)
> 
> For ACKNOWLEDGE, maybe "indicates that the driver has discovered the
> device and recognized it as a valid virtio device" (i.e. mostly what we
> have now), but also add "For example, this can indicate that non-device
> specific virtio driver code has attached to the device."
> 
> For DRIVER, maybe "indicates that the driver has discovered that it
> knows how to drive this device specifically. For example, this can
> indicate that device-specific driver code has attached to the device."


I feel examples are a weak way to document it - if we can not say
what this is specifically, what purpose does it serve?
Actually, we do have a distinction, between transport and device type.
Can't we use that? It seems more consistent than "non-device
specific" and "device specific".


SO I propose:

\item[ACKNOWLEDGE (1)] Indicates that a transport driver has found the
    device and recognized it as a valid virtio device transport.
  
\item[DRIVER (2)] Indicates that a device type specific driver was found
    and will attempt to attach to the device.



BTW somewhat related, I would maybe fix
device-types/mem/description.tex:change
not to say "device driver", just "driver" for brevity.





> Probably need some more overhaul :) Not an editorial change in any case.
> 
> >> @@ -473,13 +473,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
> >>  \begin{enumerate}
> >>  \item Reset the device.
> >>  
> >> -\item Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
> >> +\item Set the ACKNOWLEDGE status bit: the driver has noticed the device.
> >>  
> >> -\item Set the DRIVER status bit: the guest OS knows how to drive the device.
> >> +\item Set the DRIVER status bit: the driver knows how to drive the device.
> >
> > besides the above, "drivers knows how to drive" sounds bad.
> >
> >>  \item\label{itm:General Initialization And Device Operation /
> >>  Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
> >> -   understood by the OS and driver to the device.  During this step the
> >> +   understood by the driver to the device.  During this step the
> >
> > Again the "the OS" here referred to core virtio (e.g. ring features).
> > Less of a problem to remove but if we come up with
> > a better terminology for ACKNOWLEDGE/DRIVER then I guess we can use it
> > here, too.
> 
> Hm, I'm not sure how far we need to distinguish between generic and
> device-specific features in this case. The "driver" as the whole entity
> driving the device needs to decide on the subset; at this stage, it does
> not really matter which parts of the driver code accepted which
> feature. We probably want to be explicit that features are ring,
> transport, and device features, though.

OK.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

