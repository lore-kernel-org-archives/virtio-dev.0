Return-Path: <virtio-dev-return-14337-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C8C48BC3
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 05:09:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A26019090F
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 05:09:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDB5998652B
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Feb 2024 05:09:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFB4B983EB1; Tue, 20 Feb 2024 05:09:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DC549864A3
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2024 05:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708405769; x=1709010569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUgmCcoPzeGGSIZ7yv1ET12EGtD1tSWH2zBUkZjsG0o=;
        b=OgqOjBMQUlk/l/GCPWW+CWmz9hNdTS1PMLIlYcW++nQtGPGkVReA+wcit1Tk6/lJij
         hOc41Ay3zEf9FSP9vvX5ubR1f0Q1RRG9/x81tXzYjuxc7qhpPqpgaHFxKcAVDAHEe6q/
         JILFFWrB+fB3unQ8Sm5QbKM3jk5gVw8CxESc+76sXvRm1BYznH4UoIlUSzPmAEwHI/bj
         bhq2ssoMoWvabzntzqfGCVC5a+XrOLGCdHFNnJ3zL1eWlSOaICmHEjjmcwNKbfv9l+Uk
         ENvMzwz7CPwwcoRwQwxJtfksMEJ9/aQovdwwf7y0aYVI4XucRFYZanJtdtb0J+iSfhsi
         zFPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1IglnpRJyVGXN38K2bCOQdQRNnChMLPv7FYSE0hZHDPFfni7zTpbex1Vbn/DhrKmR4ZIl3sFs5rBK8sYx81WQ7uryAitPjywG/bT63p3S
X-Gm-Message-State: AOJu0YxVN/luERiV3wqsyMxLVWLzgtr38n4YxKKN/q9k+qPQPp4Ij1f8
	yrVY1ChTdVeFu1GI9Yt3ByFxgFIS0I1jUFqCp35g2UPqLkFE4NvE7C/Ad/5PyfU1F5QtBKv7/QK
	EE2L5p7F+h2rjeNw61kTY/svBbUFBSffrspNN
X-Google-Smtp-Source: AGHT+IHderXkRdSPUQFyb5BAvUXWBhY1zcOZ/ue5wxgC5egKBlnprCFMkgumOdXHR5PMBU/Ou56EZtdhUIVqnHJpNeQ=
X-Received: by 2002:ac2:55a9:0:b0:511:8748:c3b with SMTP id
 y9-20020ac255a9000000b0051187480c3bmr8594133lfg.2.1708405769230; Mon, 19 Feb
 2024 21:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20240218132306.83456-1-lingshan.zhu@intel.com>
 <20240218090935-mutt-send-email-mst@kernel.org> <CAD=HUj4b3gLsA2VD4cxmVzLPGRZfaREQcJNb4zfxLH=xv=2X6g@mail.gmail.com>
 <be09ad18-398e-47c0-abea-3f025df40734@intel.com>
In-Reply-To: <be09ad18-398e-47c0-abea-3f025df40734@intel.com>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 20 Feb 2024 14:09:18 +0900
Message-ID: <CAD=HUj6iVc=QpA6kGyNhdM-BrD5tuAj1yUkS6gJtU+hi=QmtLg@mail.gmail.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, eperezma@redhat.com, 
	cohuck@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status

On Tue, Feb 20, 2024 at 1:06=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
> On 2/19/2024 2:46 PM, David Stevens wrote:
> > On Sun, Feb 18, 2024 at 11:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> >> On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
> >>> This commit allows the driver to suspend the device by
> >>> introducing a new status bit SUSPEND in device_status.
> >>>
> >>> This commit also introduce a new feature bit VIRTIO_F_SUSPEND
> >>> which indicating whether the device support SUSPEND.
> >>>
> >>> This SUSPEND bit is transport-independent.
> >>>
> >>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> Could we get some kind of dscription how this has taken into
> >> consideration the proposal from David Stevens?
> >>
> >> I find it really tiring when there are competing patches with authors
> >> ignoring each other's work and leaving it up to reviewers to
> >> figure out how do the patches compare.
> > This patch looks like it could be used to implement my use case.
> > However, parts of it are a bit vague and imprecise, so it's hard to
> > actually say whether my use case would actually be covered by a
> > specific implementation of this proposal.
> I am on vacation till this Friday. Shall we co-work on this and
> post something new together?

That works for me.

> >
> > To give specifics on what I'm trying to do, I need to allow a guest
> > with virtio-pci devices (including stateful devices like virtio-fs and
> > virtio-gpu) to be put into S1/S3, and to allow the virtio-pci devices
> > to wake up the guest (currently via an ACPI GPE, but eventually via a
> > native PCI PME). This is all done on a consumer device, so there is no
> > need for snapshotting or for live migration.
> Suspending is not dedicated only for live migration.
> For your use case, shall we add a new PCI section like saying: when enter=
ing
> SUSPEND, the device should get into S1/S3 and other PCI specific steps
> in PCI transport charter.
>
> That is because PCI is a transport layer of virtio, controlling virtio
> states by PCI sounds like a layer violation.

I don't know if it's really necessary to mandate that in the spec.
Sure, most systems are probably going to want to put the virtio-pci
device into S1/S3 after suspending virtio operation. But nothing
really breaks or goes wrong if we don't do that.

> >
> >>> ---
> >>>   content.tex | 34 ++++++++++++++++++++++++++++++++--
> >>>   1 file changed, 32 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/content.tex b/content.tex
> >>> index 0a62dce..3d656b5 100644
> >>> --- a/content.tex
> >>> +++ b/content.tex
> >>> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> >>>
> >>>   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experi=
enced
> >>>     an error from which it can't recover.
> >>> +
> >>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates t=
hat the
> >>> +  device has been suspended by the driver.
> >>>   \end{description}
> >>>
> >>>   The \field{device status} field starts out as 0, and is reinitializ=
ed to 0 by
> >>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> >>>   recover by issuing a reset.
> >>>   \end{note}
> >>>
> >>> +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
> >>> +
> >>> +When setting SUSPEND, the driver MUST re-read \field{device status} =
to ensure the SUSPEND bit is set.
> >>> +
> >>>   \devicenormative{\subsection}{Device Status Field}{Basic Facilities=
 of a Virtio Device / Device Status Field}
> >>>
> >>>   The device MUST NOT consume buffers or send any used buffer
> >>> @@ -82,6 +89,25 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> >>>   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_=
NEEDS_RESET, the device
> >>>   MUST send a device configuration change notification to the driver.
> >>>
> >>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> >>> +
> >>> +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated=
.
> >>> +
> >>> +The device SHOULD allow settings to \field{device status} even when =
SUSPEND is set.
> >>> +
> >>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHO=
ULD clear SUSPEND
> >>> +and resumes operation upon DRIVER_OK.
> >>> +
> >>> +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
> >>> +the device SHOULD perform the following actions before presenting SU=
SPEND bit in the \field{device status}:
> >>> +
> >>> +\begin{itemize}
> >>> +\item Stop consuming buffers of any virtqueues and mark all finished=
 descriptors as used.
> >>> +\item Wait until all descriptors that being processed to finish and =
mark them as used.
> >>> +\item Flush all used buffer and send used buffer notifications to th=
e driver.
> > What's the difference between the previous three lines? They might be
> > trying to say different things, but there is a lot of overlap in how
> > they're phrased. That makes it hard to figure out exactly what they're
> > mandating. Is it something like: "stop processing new buffers",
> > "finish processing any buffers that are currently in flight", "mark
> > all finished buffers as used and send a used buffer notification"?
> sure, the "mark used" parts can merge.
> >
> > Also, what does this mean for devices where the driver places empty
> > buffers into the virtqueue that the device then holds on to for an
> > indeterminate period of time (e.g. network receiveq, balloon statsq,
> > etc)?
> The device doesn't process them.
> Oh, I should add: The driver should not make any more buffers available
> to the device.
> >
> >>> +\item Pause its operation except \field{device status} and preserve =
configurations in its Device Configuration Space, see \ref{sec:Basic Facili=
ties of a Virtio Device / Device Configuration Space}
> > What does "Pause its operation except device status" mean? The word
> > "operation" is vague, what exactly does it include? Also what does
> > "operate its device status" mean?
> Because we need to resume the device after suspending it by setting
> DRIVER_OK, so we need the device status
> filed keel alive.

This doesn't answer what "Pause its operation" means. If the
specification is not precise, then the best that can be implemented is
for a specific device to be compatible with a specific driver. If we
actually want portable, spec-compliant devices, we need explicitly
defined MUST/MUST NOT requirements. Presumably we want something like:

A device MUST not send notifications while suspended.
A device MUST ignore writes to its device configuration while
suspended, except for writes to the device status byte.
A driver MUST NOT write to a suspended device's configuration space,
except for the device status byte.

We also need to specify what a suspended device is allowed to do with
buffers it owns. For my use case of just suspending/resuming a VM, I
don't think it particularly matters if a suspended device writes to
buffers or descriptors while it is suspended. But based on what you
wrote about finishing any in-flight processing of buffers and not
processing any empty buffers, presumably you would prefer that the
device not be allowed to access buffer/descriptors while it is
suspended? That approach is probably cleaner from a pure specification
standpoint, but it's also more restrictive for devices and thus harder
to properly implement.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

