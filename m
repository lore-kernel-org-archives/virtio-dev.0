Return-Path: <virtio-dev-return-14331-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871D3C48BC3
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE2FA2AF8C
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D54EC98666A
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Feb 2024 06:46:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4415986511; Mon, 19 Feb 2024 06:46:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC4D1986561
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Feb 2024 06:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708325208; x=1708930008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1yODBd0gtrAjDNpMvsYGcKbOnoMHa2eVww11Z7ajO0=;
        b=CW0sYk4xJBUaFpPxAhSgHzOnPeHrdVj7CiDtDESSI7qYDlL3l/rthM5ZiFneM7lKcP
         W1oNSepkVLEGtAktJ+P3xZ3wTBZaUaCM55x1JTBmlhN9v8GbBg47RBy21LWgb99oel8x
         1hmn3FwxBiRLF6PCiqkQu43zapt3WsQvkNphhB+leb8O1jrGR/2yrcPlsJ+V3Z7pmET4
         AonOdGyU8Hf+juPyX4e0gMV3JIROzQMASyHvCGnK3jv8kYqaFvPVUn9qr08YOA34MZrp
         vO95BOMKvU4h5XzLdLG0q1mMuCoTjAKaZSDzQDYzNj9nommxPsYH6WnYEOKoCQt2ai6j
         g0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+afpkKJDflLx9cgcKtsE0x1IU92F0kYpfCTxMRmbq+/ErYJ0iygux2j7nxluIh6EZVOb2O8GvbwJ49/YU/qrOQ2Te0l5oMygL/3cSb8sd
X-Gm-Message-State: AOJu0YznglUz1URu2foqCAOeNk+D5ZxoAvmLz3umpQ7DzeqBgbwQCfiD
	Rqmwq/bZZfGLNT6ybUlEmLWsdnKMslOONPkchgrd6hjHv+jn7AcnpU6GRKdtvHBEBUnYgNmUwOA
	JJCBHdF3DaybCR7yyhRRlPo/panK4SjIpTJqf
X-Google-Smtp-Source: AGHT+IFaK/8rv/5QtmAnLQnpkAcSyqYjBoB+6oqA7S5bD81b0n6xD+Ej9pQl7Q2INAOR1TE4eXbw9SF84FFeeJYLQp0=
X-Received: by 2002:a2e:8e92:0:b0:2d2:3a77:b304 with SMTP id
 z18-20020a2e8e92000000b002d23a77b304mr1014396ljk.1.1708325208518; Sun, 18 Feb
 2024 22:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20240216082432.709956-1-stevensd@chromium.org>
 <20240216082432.709956-2-stevensd@chromium.org> <20240216035144-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240216035144-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 19 Feb 2024 15:46:37 +0900
Message-ID: <CAD=HUj79esxJTKZNMk3MkWOW5Ch=9L4kuokjvPryuTsV2z=sdA@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v4 1/1] Add suspend support for virtio PCI devices

On Fri, Feb 16, 2024 at 5:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 16, 2024 at 05:24:32PM +0900, David Stevens wrote:
> > Add a virtio power management PCI capability to allow drivers to suspen=
d
> > virtio PCI devices. This allows drivers to suspend devices at the virti=
o
> > level before suspending them at the PCI transport layer. This allows
> > drivers to do a two phase suspend, which prevents notifications from
> > being ignored or lost if interrupts are reconfigured at the PCI
> > transport layer immediately before or after the device is put into the
> > PCI PM D3 low power state.
> > ---
> >  transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/transport-pci.tex b/transport-pci.tex
> > index a5c6719ea871..ce77708a9b69 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -188,6 +188,8 @@ \subsection{Virtio Structure PCI Capabilities}\labe=
l{sec:Virtio Transport Option
> >  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> >  /* Vendor-specific data */
> >  #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> > +/* Power management configuration */
> > +#define VIRTIO_PCI_CAP_PM_CFG            10
> >  \end{lstlisting}
> >
> >          Any other value is reserved for future use.
> > @@ -804,6 +806,55 @@ \subsubsection{PCI configuration access capability=
}\label{sec:Virtio Transport O
> >  specified by some other Virtio Structure PCI Capability
> >  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
> >
> > +\subsubsection{Power management capability}\label{sec:Virtio Transport=
 Options / Virtio Over PCI Bus / PCI Device Layout / Power management capab=
ility}
> > +
> > +The VIRTIO_PCI_CAP_PM_CFG capability refers to a single byte. The
> > +driver can write to the byte to set the power state of the device,
> > +and it can read from the byte to get the current power state of the
> > +device.
> > +
> > +The valid power states are:
> > +
> > +\begin{lstlisting}
> > +/* Device is operating normally */
> > +#define VIRTIO_PM_STATE_ACTIVE    0
> > +/* Device operation is suspended */
> > +#define VIRTIO_PM_STATE_SUSPENDED 1
> > +\end{lstlisting}
> > +
> > +The device power state has no effect when \field{device status} does
> > +not have the DRIVER_OK bit set or does have the DEVICE_NEEDS_RESET bit
> > +set.
>
>
> Given this is only after DRIVER_OK, wouldn't a feature bit + status bit
> make more sense? This will make it transport-independent and simplify
> discovery.

A feature bit + status bit would work as well. I've posted some
questions on Zhu Lingshan's patch.

> > +\devicenormative{\paragraph}{Power management capability}{Virtio Trans=
port Options / Virtio Over PCI Bus / PCI Device Layout / Power management c=
apability}
> > +
> > +A device MUST maintain its state while suspended such that all driver
> > +visible state after resuming exactly matches driver visible state
> > +before suspending.
> > +
> > +A device MUST NOT send notifications while suspended.
> > +
> > +A device MAY operate on any buffers in its virtqueue while suspended.
>
> How is this reconsiled with state matching exactly? buffers are
> driver-visible ...

Drivers can't atomically access buffers and the PM byte, so the device
modifying a buffer while suspended is indistinguishable from the
device modifying a buffer in the window between when it is resumed by
the driver and when the driver accesses the buffer. But you are right
that the wording is contradictory. Maybe the earlier requirement could
be better phrased as:

A device MUST maintain its state while suspended such that after the
driver resumes the device, the driver can use the device as if it had
never been suspended in the first place.

> > +A device MUST set its power state to VIRTIO_PM_STATE_ACTIVE on reset.
> > +
> > +A device SHOULD take steps to minimize its resource consumption while
> > +suspended, although what this involves is specific to the particular
> > +device implementation.
> > +
> > +\drivernormative{\paragraph}{Power management capability}{Virtio Trans=
port Options / Virtio Over PCI Bus / PCI Device Layout / Power management c=
apability}
> > +
> > +A driver MUST NOT access a suspended device's BARs corresponding to
> > +any virtio structures, except for the power management byte.
> > +
> > +A driver MAY suspend a device that has buffers in one of its
> > +virtqueues, but it MUST NOT modify any such buffers while the device
> > +is suspended.
> > +
> > +A driver MUST read from the power management byte after writing to the
> > +byte to verify that the device successfully entered the target power
> > +state.
>
> Verify how? By checking the value returned? And what should it do with th=
e value
> does not match?

Yes, comparing the value returned to the one it just wrote. The three
options I can think of would be to abort the suspend, reset the
device, or retry. Retry only makes sense if suspend/resume might
succeed in the future. An API is really only retry-friendly if it has
a way to set a timeout, since the consumer is what should be deciding
how long to wait but can't make that decision without a timeout.
Personally, I would lean towards not allowing timeouts here, since
it's simpler. So maybe something like this:

After the driver writes a new value to the PM byte, if the device can
transition to the requested state, then subsequent reads of the PM
state byte MUST block until the transition completes. If the device
cannot transition to the requested state, it MUST immediately return
the prior value of the PM state byte for subsequent reads of the PM
state byte.

In that case, the only options are to abort the suspension or to reset
the device. That's really a policy decision of the driver, so I don't
know how it would fit into this spec.

-David


-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

