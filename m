Return-Path: <virtio-dev-return-14330-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B764FC48260
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D42F2AF88
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1324E9864D3
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07B259863ED; Mon, 19 Feb 2024 06:46:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA1A89866C4
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Feb 2024 06:46:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708325198; x=1708929998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkTB5ec5Rd2VyeWmIkrGgA1oEQ+kMnAjus2dPdt7haA=;
        b=bN9ls41ReATKBv1YteyqiUpmau2S5z7cKKX6qn6rGJ3KZHj0mwt0p8hkyDcuxXqmQW
         oht/jCm1XNTAzPaU5Cefa7hlkBkUbpWh7rYl1oikETxBX2TbOUR9Zk60HaC2F3ckG69w
         Nh8R4ekGqiv52Cu9UIdh0heOth/fH+xWKTKsCAC5LETkglaGcvWjImtUqrZ6sZ1F71vj
         ZWh0mzbAl2lfg5SA3LK8FtTNksLAz2sc4CJjNnySeK7RdQ+vP1YiYYfl0jBVJbUthqXD
         Xrtt96vv+h4rQMCnpYp5ixd7gTeIXggOxX2kSak9I8QOysgaO8/W6F1KEMfIDL18JUi+
         HRIg==
X-Forwarded-Encrypted: i=1; AJvYcCW+iHgIuhGYsLon7FUlSKuoJA0b1J2shITQPaG9a4nKwX++HITwFh0KNIWjmPqUd6TMJLgTv2iegVI+hZenYI/yiRSd/FhLwvoiwjLNM8kk
X-Gm-Message-State: AOJu0YzxTDkVvd0QRwCAo13ZATKWT4jSm+KMyrb+knI41fvGxlQBuaXK
	z/1cy3DcNOY6BjstwSXsXHflLj/E6QDLBoL/ktVKuWa4u1k4RnAgGB0RA6Pxc4kZMzTYOj7Cqbo
	qibVa8NT+pnwrzVGPvTFwkjn3/C1RQa7k57Eq
X-Google-Smtp-Source: AGHT+IH+pn66UVJNaI+MZkI9UAjdJxgaRELUHqAQKQE02eP8QobtiJF1UwpMMcY2SHzayquh0jlsKY1mkuuwJX+ziEg=
X-Received: by 2002:a2e:9607:0:b0:2d2:1107:3a3 with SMTP id
 v7-20020a2e9607000000b002d2110703a3mr7026725ljh.10.1708325198136; Sun, 18 Feb
 2024 22:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20240218132306.83456-1-lingshan.zhu@intel.com> <20240218090935-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240218090935-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 19 Feb 2024 15:46:27 +0900
Message-ID: <CAD=HUj4b3gLsA2VD4cxmVzLPGRZfaREQcJNb4zfxLH=xv=2X6g@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com, eperezma@redhat.com, 
	cohuck@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status

On Sun, Feb 18, 2024 at 11:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
> > This commit allows the driver to suspend the device by
> > introducing a new status bit SUSPEND in device_status.
> >
> > This commit also introduce a new feature bit VIRTIO_F_SUSPEND
> > which indicating whether the device support SUSPEND.
> >
> > This SUSPEND bit is transport-independent.
> >
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Could we get some kind of dscription how this has taken into
> consideration the proposal from David Stevens?
>
> I find it really tiring when there are competing patches with authors
> ignoring each other's work and leaving it up to reviewers to
> figure out how do the patches compare.

This patch looks like it could be used to implement my use case.
However, parts of it are a bit vague and imprecise, so it's hard to
actually say whether my use case would actually be covered by a
specific implementation of this proposal.

To give specifics on what I'm trying to do, I need to allow a guest
with virtio-pci devices (including stateful devices like virtio-fs and
virtio-gpu) to be put into S1/S3, and to allow the virtio-pci devices
to wake up the guest (currently via an ACPI GPE, but eventually via a
native PCI PME). This is all done on a consumer device, so there is no
need for snapshotting or for live migration.

> > ---
> >  content.tex | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 0a62dce..3d656b5 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
> >
> >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienc=
ed
> >    an error from which it can't recover.
> > +
> > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates tha=
t the
> > +  device has been suspended by the driver.
> >  \end{description}
> >
> >  The \field{device status} field starts out as 0, and is reinitialized =
to 0 by
> > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  recover by issuing a reset.
> >  \end{note}
> >
> > +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
> > +
> > +When setting SUSPEND, the driver MUST re-read \field{device status} to=
 ensure the SUSPEND bit is set.
> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of=
 a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer
> > @@ -82,6 +89,25 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEE=
DS_RESET, the device
> >  MUST send a device configuration change notification to the driver.
> >
> > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> > +
> > +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
> > +
> > +The device SHOULD allow settings to \field{device status} even when SU=
SPEND is set.
> > +
> > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOUL=
D clear SUSPEND
> > +and resumes operation upon DRIVER_OK.
> > +
> > +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
> > +the device SHOULD perform the following actions before presenting SUSP=
END bit in the \field{device status}:
> > +
> > +\begin{itemize}
> > +\item Stop consuming buffers of any virtqueues and mark all finished d=
escriptors as used.
> > +\item Wait until all descriptors that being processed to finish and ma=
rk them as used.
> > +\item Flush all used buffer and send used buffer notifications to the =
driver.

What's the difference between the previous three lines? They might be
trying to say different things, but there is a lot of overlap in how
they're phrased. That makes it hard to figure out exactly what they're
mandating. Is it something like: "stop processing new buffers",
"finish processing any buffers that are currently in flight", "mark
all finished buffers as used and send a used buffer notification"?

Also, what does this mean for devices where the driver places empty
buffers into the virtqueue that the device then holds on to for an
indeterminate period of time (e.g. network receiveq, balloon statsq,
etc)?

> > +\item Pause its operation except \field{device status} and preserve co=
nfigurations in its Device Configuration Space, see \ref{sec:Basic Faciliti=
es of a Virtio Device / Device Configuration Space}

What does "Pause its operation except device status" mean? The word
"operation" is vague, what exactly does it include? Also what does
"operate its device status" mean?

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

