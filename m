Return-Path: <virtio-dev-return-13566-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE09C3064E
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:16:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CF29C613C7
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:15:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 506C7986547
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 15:15:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 313DB9866CF; Thu, 17 Aug 2023 15:15:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11CD99865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Aug 2023 15:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Pv3ey0S4O2meNLeTlo49Xg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692285355; x=1692890155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWgXLumvfhtlBvqBqIMyEpe7Xo9Gr3YdZ2fGKkKUEYk=;
        b=eTVrFmjW7qqWkSf4s1nbuOLXimZMWd3Myxc+P/bOSRC+Oz9+12/jlHrALtjXMGCIw2
         DNqZh7GVDQJe+htsTemyBNGvvdYcxZlarnHukbJ5lVOpY8uv7slSoGl9M7N0t+3Gi9+6
         /oTKdj9zyLEe+WLsVpMID9OcwFN7gZP/qrVkJ7E+CYfHINh9vY2K8psUl+0Al46OgcKd
         XDQwVzbOupmMLzURwRArJMyBMPEsCGrIQUwj7XjCL8rgys/yN8qHyyxiTT3xvJDQnq75
         bbjg0KtmSXZmkJfrI+Rh10TR9si2mXEaqKnq+oMh01NlGY4+Gk+GU1AOrpW3xjOJBYgz
         aBqg==
X-Gm-Message-State: AOJu0YyLOzL/6exYqVKYTQzCyFnHMv4dM7Z5MKwxEKpvMITc1XqcrVbH
	+OQmznTaxCFMrVft9crYLvcv8yMiwMQOtWla+PhplBWj5vXmTh5BMJO5WB18rmO3Ha9mia50TWo
	tug0vJXu9uL1Py4pJrPf/RpE4aQcu7tQtBkPqsrto0GSV
X-Received: by 2002:a05:6358:c11:b0:134:28d6:be7 with SMTP id f17-20020a0563580c1100b0013428d60be7mr6820598rwj.9.1692285353171;
        Thu, 17 Aug 2023 08:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhWBoNsrLgyXP9xVtJPtHbpK80qDHtB4Hi5Bj+sgnXWnpkJFCBr5kieN3GJgDkFmOdPLXAre/SIwZCP6MBmtM=
X-Received: by 2002:a05:6358:c11:b0:134:28d6:be7 with SMTP id
 f17-20020a0563580c1100b0013428d60be7mr6820568rwj.9.1692285352842; Thu, 17 Aug
 2023 08:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com> <20230814143039.GD3146793@fedora>
 <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com> <20230815122916.GA3235352@fedora>
In-Reply-To: <20230815122916.GA3235352@fedora>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 17:15:16 +0200
Message-ID: <CAJaqyWd4a94FHMxAEKrQ+wpWiFECBLrWRhp24f5uYf=6TDwL+Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com, mst@redhat.com, 
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit in
 device status

On Tue, Aug 15, 2023 at 2:29=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Aug 15, 2023 at 06:31:23PM +0800, Zhu, Lingshan wrote:
> >
> >
> > On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
> > > On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
> > > > This patch introudces a new status bit in the device status: SUSPEN=
D.
> > > >
> > > > This SUSPEND bit can be used by the driver to suspend a device,
> > > > in order to stablize the device states and virtqueue states.
> > > >
> > > > Its main use case is live migration.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> > > There is an character encoding issue in Eugenio's surname.
> > Oh, I copied his SOB form his email, I will copy from git log to fix th=
is,
> > thanks for point out it.
> > >
> > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > ---
> > > >   content.tex | 18 ++++++++++++++++++
> > > >   1 file changed, 18 insertions(+)
> > > This patch hints at the asynchronous nature of the SUSPEND bit (the
> > > driver must re-read the Device Status Field) but doesn't explain the
> > > rationale or any limits.
> > >
> > > For example, is there a timeout or should the driver re-read the Devi=
ce
> > > Status Field forever?
> > It depends on the driver, normally we expect this operation can be done
> > successfully
> > like how the driver/device handles FEATURES_OK.
> >
> > Once failed due to:
> > 1) driver timeout, the driver can reset the device
> > 2) device failure, the device can set NEEDS_RESET.
>
> I mention this because SUSPEND involves quiescing the device so that no
> requests are in flight and that can take an unbounded amount of time on
> a virtio-blk, virtio-scsi, or virtiofs device. If the driver is busy
> waiting for the device to report the SUSPEND bit, then that could take a
> long time/forever.
>
> Imagine a virtiofs PCI device implemented in hardware that forwards I/O
> to a distributed storage system. If the distributed storage system has a
> request in flight then SUSPEND needs to wait for it to complete. The
> device has no control over how long that will take, but if it does not
> then corruption could occur later on.
>
> There are two issues with long SUSPEND times:
> 1. Busy wait CPU consumption. Since there is no interrupt that signals
>    when the bit is set, the best a driver can do is to back off
>    gradually and use timers to avoid hogging the CPU.
> 2. Synchronous blocking. If the call stack that led the driver to set
>    SUSPEND is blocked until the device reports the SUSPEND bit, then
>    other parts of the system could experience blocking. For example, the
>    VMM might be blocked in a vhost ioctl() call, which makes the guest
>    unresponsive.
>

I think all of this already happens with ring reset or even a plain
device reset, doesn't it?

In my opinion the best thing the device can do here is to fail the
request after a certain time, the same way it would fail if the
backend distributed storage system gets disconnected or latency gets
out of bounds.

> Making SUSPEND asynchronous is more complicated but would allow long
> SUSPEND times to be handled gracefully.
>

Maybe that should be the direction of the transport vq, so transport
commands are asynchronous and we get rid of all the similar problems
in one shot?

Thanks!

> > >
> > > Does the driver need to re-read the Device Status Field after clearin=
g
> > > the SUSPEND bit?
> > I think the driver should re-read, I will add this in the next version.
> > >
> > > > diff --git a/content.tex b/content.tex
> > > > index 0a62dce..1bb4401 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:B=
asic Facilities of a Virtio Dev
> > > >   \item[DRIVER_OK (4)] Indicates that the driver is set up and read=
y to
> > > >     drive the device.
> > > > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates=
 that the
> > > > +  device has been suspended by the driver.
> > > > +
> > > >   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has expe=
rienced
> > > >     an error from which it can't recover.
> > > >   \end{description}
> > > > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:=
Basic Facilities of a Virtio Dev
> > > >   recover by issuing a reset.
> > > >   \end{note}
> > > > +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> > > > +
> > > > +When set SUSPEND, the driver MUST re-read \field{device status} to=
 ensure the SUSPEND bit is set.
> > > "When setting SUSPEND, ..." would be grammatically correct. Another
> > > option is "After setting the SUSPEND bit, ...".
> > Will fix in the next version.
> > >
> > > > +
> > > >   \devicenormative{\subsection}{Device Status Field}{Basic Faciliti=
es of a Virtio Device / Device Status Field}
> > > >   The device MUST NOT consume buffers or send any used buffer
> > > > @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:=
Basic Facilities of a Virtio Dev
> > > >   that a reset is needed.  If DRIVER_OK is set, after it sets DEVIC=
E_NEEDS_RESET, the device
> > > >   MUST send a device configuration change notification to the drive=
r.
> > > > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> > > > +
> > > > +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiat=
ed.
>
> I noticed a typo:
> "device MUST"
>
> > > > +
> > > > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device M=
UST clear SUSPEND
> > > > +and resumes operation upon DRIVER_OK.
> > > I can't parse this sentence. If the driver writes SUSPEND | DRIVER_OK=
 |
> > > ... to the Device Status Field, then the device accepts DRIVER_OK and
> > > clears SUSPEND?
> > >
> > > Why?
> > I expect DRIVER_OK can clear SUSPEND, so that the device can resume run=
ning
> > in case of a failed live migration.
> >
> > Maybe I should say: DRIVER_OK clears SUSPEND, and if DRIVER_OK is set t=
o
> > a suspended device, the device should resume operation
>
> It's confusing because there are other Device Status Field bits aside
> from DRIVER_OK. I wasn't sure what you meant.
>
> I think this is really saying that devices must support the SUSPEND ->
> !SUSPEND transition. It's not really about DRIVER_OK because that bit
> will be set the entire time (!SUSPEND -> SUSPEND -> !SUSPEND).
>
> Can you rephrase it? For example:
>
>   If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST
>   resume operation when the driver clears the SUSPEND bit.
>
> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

