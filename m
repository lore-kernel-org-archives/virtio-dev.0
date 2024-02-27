Return-Path: <virtio-dev-return-14360-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2DFC54798
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 07:59:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 73D0F2CADE
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 07:59:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68DAF9865CD
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 07:59:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5B80D986445; Tue, 27 Feb 2024 07:59:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47EC79863B6
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 07:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020783; x=1709625583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFB4pHljPgpK5FYvsMAyM9OwIfeFCEMAPPuQsOd3ruA=;
        b=lrncGHd6ZeHpePxAZ1hNeN7Bf3c9zbiP1U2hHvqUjNKJf78UIl7G4YlrshfK9/Qrk0
         V0RiiBugmB0Yd1VJwfN0NMSKXxjtVasnzcaeK3eLXt4yFIXhMrVDxEbIeay/+VrYEoA3
         0saSxxbpbJFE6L7pCDWK0EYfrYZnF+WN8xklQMuth/HIDwkwEPN5eCaC7nHQROFyzCQM
         B8G6XgjQdlegCl5F1o+8e/A4zjvcusNsEFSNWLNe/9RBWV+7r59nspcDjcNY0rpsu2OO
         aL6jW2RW0dmcCzAZ4yxHiU4f4WuBq4Suc2Yn/+vkge5gyqlWk9pIpFpwMyvYAhOMUWpj
         +uWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZmLGLzgYZYBr8atNnfs19Ezsb5o+mSlHYOdjOjujvpYIRWYfHVJkUBmaU9RJI4+N3SH6yUHi7JWvBkc8hVFT9hNnSe7Q7I5ZTeqNdGjop
X-Gm-Message-State: AOJu0YycYYfpjzlYWKWib5NphQQy+JGTkQSExgqWeidfqWf/J2GU4VRR
	jkPBCAOe5/lB/Pvsa1+jstoY9kOurfuxhbsuDTG9WG3aG/n6hP7O6iaphIETrWbake0ShFXKTBF
	ZfVmuCyL4+NHfCbUWAb3xw06xKcMQo4Z2u1Pi
X-Google-Smtp-Source: AGHT+IH6xYV79m0yzvl3pIbTK4+e15kRFw2GbOFN6wKLcyK+XM2l7cShtuUhu4r+HuTNvSEcajcC0Pt+G99nPHjtS+w=
X-Received: by 2002:a05:6512:3193:b0:512:fd85:9dfe with SMTP id
 i19-20020a056512319300b00512fd859dfemr4256979lfe.20.1709020783190; Mon, 26
 Feb 2024 23:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20240227015345.3614965-1-stevensd@chromium.org>
 <20240227015345.3614965-2-stevensd@chromium.org> <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
In-Reply-To: <e03d003e-ca23-4dd2-aeac-6df79ee5c1e6@intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 27 Feb 2024 16:59:32 +0900
Message-ID: <CAD=HUj6gM5HUp=gGt1u=OcQRBe3A=ig5ws=ZLkJEy=Jr-caAvQ@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v5 1/1] Add SUSPEND bit to device status

On Tue, Feb 27, 2024 at 11:22=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.=
com> wrote:
> On 2/27/2024 9:53 AM, David Stevens wrote:
> > Add a SUSPEND bit to the device status field to allow drivers to suspen=
d
> > virtio devices. On systems where drivers don't directly manage interrup=
t
> > routing (e.g. Linux), this allows the drivers to suspend their devices
> > and prevent interrupts from being sent when the interrupt routing syste=
m
> > does not expect interrupts.
> > ---
> >   content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 84 insertions(+), 5 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 0a62dce5f65f..2183c63c45ea 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
> >
> >   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experien=
ced
> >     an error from which it can't recover.
> > +
> > +\item[SUSPEND (16)] Indicates that the device has been suspended by th=
e
> > +  driver. Only valid when the VIRTIO_F_SUSPEND feature bit is negotiat=
ed.
> >   \end{description}
> >
> >   The \field{device status} field starts out as 0, and is reinitialized=
 to 0 by
> > @@ -60,9 +63,11 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >   initialization sequence specified in
> >   \ref{sec:General Initialization And Device Operation / Device
> >   Initialization}.
> > -The driver MUST NOT clear a
> > -\field{device status} bit.  If the driver sets the FAILED bit,
> > -the driver MUST later reset the device before attempting to re-initial=
ize.
> > +
> > +The driver MUST NOT clear a \field{device status} bit, except for the
> > +SUSPEND bit as described in \ref{sec:General Initialization And Device
> > +Operation / Device Suspend}. If the driver sets the FAILED bit, the
> > +driver MUST later reset the device before attempting to re-initialize.
> Comparing to add a new exception, why not just re-setting DRIVER_OK to
> let the device
> clearing SUSPEND? This issue has been addressed when Eugenio working on
> a similar STOP_BIT
>
> https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html

I don't think the device status bit is bit-addressable, so it's not
possible to re-set DRIVER_OK without also either re-setting or
clearing SUSPEND.

The linked series seems to effectively do the same thing as this patch
does. Just rather than an exception for SUSPEND, it explicitly lists
the bits which shouldn't be cleared. Although on the patch doing that,
there was feedback suggesting that it be done the way this patch does
it [1]. Personally, I think either an allowlist or a blocklist is
fine.

[1] https://lists.oasis-open.org/archives/virtio-dev/202111/msg00025.html

> Not sure it is my email client bug, it shows the authorship has been
> reset and
> all sign-off-by are removed. We have been working on this since 2021,
> how about
> just include our updated patch(WIP) in a new series?

Oh, sorry. I'm not very familiar with the process of collaboration
over email like this. I wasn't sure about adding Signed-off-by for
other people that haven't ready the patch yet, but I can add them
going forward if that's what's expected. And I'll fix up authorship
and add myself as Co-authored-by next time.

-David

> Thanks
> >
> >   The driver SHOULD NOT rely on completion of operations of a
> >   device if DEVICE_NEEDS_RESET is set.
> > @@ -73,6 +78,10 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >   recover by issuing a reset.
> >   \end{note}
> >
> > +If VIRTIO_F_SUSPEND is negotiated, the driver MUST manage the SUSPEND =
bit
> > +as described in \ref{sec:General Initialization And Device Operation /
> > +Device Suspend}. Otherwise, the driver MUST NOT set the SUSPEND bit.
> > +
> >   \devicenormative{\subsection}{Device Status Field}{Basic Facilities o=
f a Virtio Device / Device Status Field}
> >
> >   The device MUST NOT consume buffers or send any used buffer
> > @@ -82,6 +91,10 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NE=
EDS_RESET, the device
> >   MUST send a device configuration change notification to the driver.
> >
> > +If VIRTIO_F_SUSPEND is negotiated, the device MUST manage the SUSPEND =
bit
> > +as described in \ref{sec:General Initialization And Device Operation /
> > +Device Suspend}. Otherwise, the device MUST ignore the SUSPEND bit.
> > +
> >   \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device =
/ Feature Bits}
> >
> >   Each virtio device offers all the features it understands.  During
> > @@ -99,10 +112,10 @@ \section{Feature Bits}\label{sec:Basic Facilities =
of a Virtio Device / Feature B
> >   \begin{description}
> >   \item[0 to 23, and 50 to 127] Feature bits for the specific device ty=
pe
> >
> > -\item[24 to 41] Feature bits reserved for extensions to the queue and
> > +\item[24 to 42] Feature bits reserved for extensions to the queue and
> >     feature negotiation mechanisms
> >
> > -\item[42 to 49, and 128 and above] Feature bits reserved for future ex=
tensions.
> > +\item[43 to 49, and 128 and above] Feature bits reserved for future ex=
tensions.
> >   \end{description}
> >
> >   \begin{note}
> > @@ -629,6 +642,67 @@ \section{Device Cleanup}\label{sec:General Initial=
ization And Device Operation /
> >
> >   Thus a driver MUST ensure a virtqueue isn't live (by device reset) be=
fore removing exposed buffers.
> >
> > +\section{Device Suspend}\label{sec:General Initialization And Device O=
peration / Device Suspend}
> > +
> > +When the VIRTIO_F_SUSPEND feature is negotiated, the driver can set th=
e
> > +SUSPEND bit in \field{device status} to suspend a live device, and can
> > +clear the SUSPEND bit to resume a suspended device. A suspended device
> > +should pause its operation, but it must maintain it state such that it
> > +can immediately continue operation upon being resumed.
> > +
> > +Suspending a device via the SUSPEND bit is a seperate process from any
> > +transport-specific suspend mechanism.
> > +
> > +\drivernormative{\subsection}{Device Suspend}{General Initialization A=
nd Device Operation / Device Suspend}
> > +
> > +The driver MUST NOT set the SUSPEND bit if the DRIVER_OK bit is not se=
t.
> > +
> > +After writing a new value to the SUSPEND bit, the driver MUST wait for
> > +the device to acknowledged the transition by reading from \field{devic=
e
> > +status} until the returned value of the SUSPEND bit matches the writte=
n
> > +value. During this period, the driver MAY abort the transition by writ=
ing
> > +a new value to the SUSPEND bit or by resetting the device.
> > +
> > +A driver MUST NOT access the device configuration space of a suspended
> > +device, except for \field{device status}.
> > +
> > +A driver MAY suspend a device that has buffers in its virtqueues. Whil=
e
> > +the device is suspended, a driver MUST NOT modify any available buffer=
s
> > +or their descriptors.
> > +
> > +A driver MUST NOT make any new buffers available to a suspended device=
.
> > +
> > +If a transport-specific suspend mechanism is available, the driver SHO=
ULD
> > +use it to put the device into a deeper suspend state after setting the
> > +SUSPEND bit.
> > +
> > +\drivernormative{\subsection}{Device Suspend}{General Initialization A=
nd Device Operation / Device Suspend}
> > +
> > +A device MUST ignore writes to the SUSPEND bit if the DRIVER_OK bit is
> > +not set.
> > +
> > +A device MUST maintain its state while suspended such that all driver
> > +visible state after resuming exactly matches driver visible state
> > +before suspending.
> > +
> > +A device MUST ignore all writes to its configuration space while
> > +suspended, except for writes to \field{device status}.
> > +
> > +A device MUST NOT send notifications, access any virtqueues, or modify
> > +any fields in its configuration space while suspended.
> > +
> > +A device MAY send notifications, access any virtqueues, or modify its
> > +configuration space after the driver writes the SUSPEND bit but before
> > +the device acknowledges the transition by returning a \field{device
> > +status} value with the SUSPEND bit set. A device SHOULD finish process=
ing
> > +and send the used buffer notification for any buffers it is able to
> > +before acknowledging the transition, but MAY retain buffers that canno=
t
> > +be immiedately processed (e.g. empty buffers in a network recieveq).
> > +
> > +A device SHOULD take steps to minimize its resource consumption while
> > +suspended, although what this involves is specific to the particular
> > +device implementation.
> > +
> >   \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options=
}
> >
> >   Virtio can use various different buses, thus the standard is split
> > @@ -872,6 +946,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved=
 Feature Bits}
> >       \ref{devicenormative:Basic Facilities of a Virtio Device / Featur=
e Bits} for
> >       handling features reserved for future use.
> >
> > +  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver c=
an
> > +    suspend the device via the SUSPEND bit in \field{device status} (s=
ee
> > +    \ref{sec:Basic Facilities of a Virtio Device / Device Status Field=
}).
> > +
> > +
> >   \end{description}
> >
> >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bi=
ts}
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

