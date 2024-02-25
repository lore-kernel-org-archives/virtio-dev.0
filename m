Return-Path: <virtio-dev-return-14349-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430B2C47DD9
	for <virtio-dev@archiver.kernel.org>; Sun, 25 Feb 2024 08:52:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 731FA2AF7F
	for <virtio-dev@archiver.kernel.org>; Sun, 25 Feb 2024 08:52:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 517C7986083
	for <virtio-dev@archiver.kernel.org>; Sun, 25 Feb 2024 08:52:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 365F4983FE6; Sun, 25 Feb 2024 08:52:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2241098401F
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2024 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pmH3VmHLMzmklC2vrpnn8Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708851126; x=1709455926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgpkB2SL0LbyogIOUN7KIDVhPp9vlYgNrnkI2akBOtI=;
        b=auXuVCiyNtxoTvlL05V6BOuWTUFwYSTTYJsnAr0123UxUHNg88xy3kNkZPTv8Uyxrh
         F4OeG/RmAnHh9/yMHjXRzDFNwtlYsFAoc4DqhO31vYiwkA0qFnGH9TAfqvVfUYa3qyuL
         DTbLPMigE4u39lSL7gM5xl1Y7M+2XhzNp2dwaWdosKfJelIj7eBpXkJO1kPrQwMJL4yr
         XeqwIp9AFYKoto1nS15KurwJcwb+9VdKX/mZ/eKVb3LT/0cRyJGTSwwLP65EdATiEw91
         yqLOANSvsp5euxAkJZhbxn5dHEZAO6SV5WQJS6D6II8O2BI3Tg3wpdlFFbZsMrmLwelp
         +tRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmaGEDBhFm0K906nKSKHQgrq4r9olQPPZS84BjR3pJvnTAfheSHEJZnQ4U5nl3BZ8mKvyNvyGghM6bWuFcftr13NJFz2vcpDmnNqa9O7Te
X-Gm-Message-State: AOJu0YwbG4NQfxk1PbK3P0cyKyXV0ZSPcI0Xq3w1NZrVsW2zKrtCd0WC
	LJtj46MFm0z6t/251SNI95jF8PEEXroLgf0Azk7DtfYZ7N/k4+qVw4JCgUOkQZZPycs4wQSn4oy
	Q7HkE9BjenAc0bGxovVe1ghVE+RO7lCaMzWFIJXJ8eS4f/CfrhP4dntmPvi00SFDxNw==
X-Received: by 2002:adf:e64c:0:b0:33d:a4f3:a670 with SMTP id b12-20020adfe64c000000b0033da4f3a670mr3160975wrn.18.1708851126379;
        Sun, 25 Feb 2024 00:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu8BO/fJnMcPxz5oVfwtVXi5ct4VzLIcpxB+gWLMAuB2nVruQ5YEns+DpcUQdvs0y3+M0pTA==
X-Received: by 2002:adf:e64c:0:b0:33d:a4f3:a670 with SMTP id b12-20020adfe64c000000b0033da4f3a670mr3160954wrn.18.1708851125760;
        Sun, 25 Feb 2024 00:52:05 -0800 (PST)
Date: Sun, 25 Feb 2024 03:52:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: David Stevens <stevensd@chromium.org>, jasowang@redhat.com,
	eperezma@redhat.com, cohuck@redhat.com, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20240225034902-mutt-send-email-mst@kernel.org>
References: <20240218132306.83456-1-lingshan.zhu@intel.com>
 <20240218090935-mutt-send-email-mst@kernel.org>
 <CAD=HUj4b3gLsA2VD4cxmVzLPGRZfaREQcJNb4zfxLH=xv=2X6g@mail.gmail.com>
 <be09ad18-398e-47c0-abea-3f025df40734@intel.com>
 <CAD=HUj6iVc=QpA6kGyNhdM-BrD5tuAj1yUkS6gJtU+hi=QmtLg@mail.gmail.com>
 <70693394-289e-42d0-a6da-b41bfab28c44@intel.com>
MIME-Version: 1.0
In-Reply-To: <70693394-289e-42d0-a6da-b41bfab28c44@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status

On Fri, Feb 23, 2024 at 03:44:41PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 2/20/2024 1:09 PM, David Stevens wrote:
> > On Tue, Feb 20, 2024 at 1:06 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> > > On 2/19/2024 2:46 PM, David Stevens wrote:
> > > > On Sun, Feb 18, 2024 at 11:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
> > > > > > This commit allows the driver to suspend the device by
> > > > > > introducing a new status bit SUSPEND in device_status.
> > > > > > 
> > > > > > This commit also introduce a new feature bit VIRTIO_F_SUSPEND
> > > > > > which indicating whether the device support SUSPEND.
> > > > > > 
> > > > > > This SUSPEND bit is transport-independent.
> > > > > > 
> > > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > Could we get some kind of dscription how this has taken into
> > > > > consideration the proposal from David Stevens?
> > > > > 
> > > > > I find it really tiring when there are competing patches with authors
> > > > > ignoring each other's work and leaving it up to reviewers to
> > > > > figure out how do the patches compare.
> > > > This patch looks like it could be used to implement my use case.
> > > > However, parts of it are a bit vague and imprecise, so it's hard to
> > > > actually say whether my use case would actually be covered by a
> > > > specific implementation of this proposal.
> > > I am on vacation till this Friday. Shall we co-work on this and
> > > post something new together?
> > That works for me.
> Cool! How about two patches in a new series:
> 1) a general virtio suspending patch describing suspending behaviors for all
> virtio devices from me, an updating version of this patch
> 2) a PCI transport suspending patch from you, describing PCI specific
> behaviors.
> 
> Dose this sound good to you?

Well David's patch was more precise than yours, and also better worded.
So think if there's an agreement you guys would really start with that,
move the functionality to the status bit and make other changes as needed.



> > 
> > > > To give specifics on what I'm trying to do, I need to allow a guest
> > > > with virtio-pci devices (including stateful devices like virtio-fs and
> > > > virtio-gpu) to be put into S1/S3, and to allow the virtio-pci devices
> > > > to wake up the guest (currently via an ACPI GPE, but eventually via a
> > > > native PCI PME). This is all done on a consumer device, so there is no
> > > > need for snapshotting or for live migration.
> > > Suspending is not dedicated only for live migration.
> > > For your use case, shall we add a new PCI section like saying: when entering
> > > SUSPEND, the device should get into S1/S3 and other PCI specific steps
> > > in PCI transport charter.
> > > 
> > > That is because PCI is a transport layer of virtio, controlling virtio
> > > states by PCI sounds like a layer violation.
> > I don't know if it's really necessary to mandate that in the spec.
> > Sure, most systems are probably going to want to put the virtio-pci
> > device into S1/S3 after suspending virtio operation. But nothing
> > really breaks or goes wrong if we don't do that.
> Yes, maybe not S1/S3, I remember you want to manage power in PCI
> transport when suspend in a cap, S1/S3 is just an example.
> 
> > 
> > > > > > ---
> > > > > >    content.tex | 34 ++++++++++++++++++++++++++++++++--
> > > > > >    1 file changed, 32 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/content.tex b/content.tex
> > > > > > index 0a62dce..3d656b5 100644
> > > > > > --- a/content.tex
> > > > > > +++ b/content.tex
> > > > > > @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
> > > > > > 
> > > > > >    \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
> > > > > >      an error from which it can't recover.
> > > > > > +
> > > > > > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
> > > > > > +  device has been suspended by the driver.
> > > > > >    \end{description}
> > > > > > 
> > > > > >    The \field{device status} field starts out as 0, and is reinitialized to 0 by
> > > > > > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
> > > > > >    recover by issuing a reset.
> > > > > >    \end{note}
> > > > > > 
> > > > > > +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
> > > > > > +
> > > > > > +When setting SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
> > > > > > +
> > > > > >    \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
> > > > > > 
> > > > > >    The device MUST NOT consume buffers or send any used buffer
> > > > > > @@ -82,6 +89,25 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
> > > > > >    that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
> > > > > >    MUST send a device configuration change notification to the driver.
> > > > > > 
> > > > > > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> > > > > > +
> > > > > > +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
> > > > > > +
> > > > > > +The device SHOULD allow settings to \field{device status} even when SUSPEND is set.
> > > > > > +
> > > > > > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD clear SUSPEND
> > > > > > +and resumes operation upon DRIVER_OK.
> > > > > > +
> > > > > > +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
> > > > > > +the device SHOULD perform the following actions before presenting SUSPEND bit in the \field{device status}:
> > > > > > +
> > > > > > +\begin{itemize}
> > > > > > +\item Stop consuming buffers of any virtqueues and mark all finished descriptors as used.
> > > > > > +\item Wait until all descriptors that being processed to finish and mark them as used.
> > > > > > +\item Flush all used buffer and send used buffer notifications to the driver.
> > > > What's the difference between the previous three lines? They might be
> > > > trying to say different things, but there is a lot of overlap in how
> > > > they're phrased. That makes it hard to figure out exactly what they're
> > > > mandating. Is it something like: "stop processing new buffers",
> > > > "finish processing any buffers that are currently in flight", "mark
> > > > all finished buffers as used and send a used buffer notification"?
> > > sure, the "mark used" parts can merge.
> > > > Also, what does this mean for devices where the driver places empty
> > > > buffers into the virtqueue that the device then holds on to for an
> > > > indeterminate period of time (e.g. network receiveq, balloon statsq,
> > > > etc)?
> > > The device doesn't process them.
> > > Oh, I should add: The driver should not make any more buffers available
> > > to the device.
> > > > > > +\item Pause its operation except \field{device status} and preserve configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
> > > > What does "Pause its operation except device status" mean? The word
> > > > "operation" is vague, what exactly does it include? Also what does
> > > > "operate its device status" mean?
> > > Because we need to resume the device after suspending it by setting
> > > DRIVER_OK, so we need the device status
> > > filed keel alive.
> > This doesn't answer what "Pause its operation" means. If the
> > specification is not precise, then the best that can be implemented is
> > for a specific device to be compatible with a specific driver. If we
> > actually want portable, spec-compliant devices, we need explicitly
> > defined MUST/MUST NOT requirements. Presumably we want something like:
> > 
> > A device MUST not send notifications while suspended.
> The device should send a last used buffer notification if
> it has buffers under processing before presenting SUSPEND
> in the device status, but the device should not process
> any new buffers. These are in devicenormative section,
> but they may be vague, I can add more details to make
> it precise, thanks for the tips
> > A device MUST ignore writes to its device configuration while
> > suspended, except for writes to the device status byte.
> > A driver MUST NOT write to a suspended device's configuration space,
> > except for the device status byte.
> sure, we can make it more precise than only pausing.
> > 
> > We also need to specify what a suspended device is allowed to do with
> > buffers it owns. For my use case of just suspending/resuming a VM, I
> > don't think it particularly matters if a suspended device writes to
> > buffers or descriptors while it is suspended. But based on what you
> > wrote about finishing any in-flight processing of buffers and not
> > processing any empty buffers, presumably you would prefer that the
> > device not be allowed to access buffer/descriptors while it is
> > suspended? That approach is probably cleaner from a pure specification
> > standpoint, but it's also more restrictive for devices and thus harder
> > to properly implement.
> When the driver sets SUSPEND, the device should finished all buffers that
> already under processing, include the in-flight buffers(or it may lose the
> buffers).
> And the device should not touch the buffers once it present SUSPEND in the
> device status field, because once it presents SUSPEND, the device state
> should
> be stable, people may use SUSPEND to debug the device.
> 
> The device still can process the buffer before it presenting SUSPEND.
> 
> Thanks
> Zhu Lingshan
> > 
> > -David


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

