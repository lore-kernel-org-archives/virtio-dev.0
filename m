Return-Path: <virtio-dev-return-11454-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AA7C6FD1A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:40:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8891CF3F6B
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:40:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2346C9866BD
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:40:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D22539866ED; Mon,  6 Mar 2023 18:40:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D6789866C0
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 18:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RRifOw4wP2-wDNHhKZBmsw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy7tEv7DWPoU238sJlWloNN/UwCXfGK128hD8MbcM5M=;
        b=tAb0C/yoeqWCXhKJ0AJ0f5b1dy2cQ8fjDJ9ADnsf7VGmMVp10shs3NkALTiFP7rqBS
         2AW0GsXsgZsTXVW88ivEpkq36XQCFVv0dXnCPLk+rVCe4Pvk43vGY8h8vWdazpnbcmx8
         h2U44PV6uUS0lxHrHiWHYknkYOnthlTarGdiZVOvrA1qxE0yAPcowkA+rkc8PIKT2uoC
         5JFuzFgIq/9SW91bFaLH8eQIXEYMg0KG5Zven3I76VJgEdrAFj8LuC0cD3Y18O4ubCh7
         3r7EH4oygY1q7SR2LHjs7zpPddh2bFqlcbLoYyoExH4Y3WReT80gcjvhR/EHAyjDmGzg
         8hOA==
X-Gm-Message-State: AO0yUKXbEQM+XHZgJlH7Cvaq34XAVhbbq76HZsESqc27sp36480myWP7
	NkQy+AmnKX0lUol5KkT1DSm5wquMXo+ASnu0dECbEfAsfZnq+yi3KZxZpSeLiGsK1pVxi5Zdn/8
	0706dcdM0zGiglznTu+8MKUUiJXh/
X-Received: by 2002:a05:600c:4f0e:b0:3e8:490b:e286 with SMTP id l14-20020a05600c4f0e00b003e8490be286mr10056850wmq.14.1678128049272;
        Mon, 06 Mar 2023 10:40:49 -0800 (PST)
X-Google-Smtp-Source: AK7set8MZsK7vzIjpnOWcvHWd73zkm1HtlIKx2mDXT5BA8mgpFaA3mGxBA9Y0nVkx6EBXc3wdcDszA==
X-Received: by 2002:a05:600c:4f0e:b0:3e8:490b:e286 with SMTP id l14-20020a05600c4f0e00b003e8490be286mr10056833wmq.14.1678128048979;
        Mon, 06 Mar 2023 10:40:48 -0800 (PST)
Date: Mon, 6 Mar 2023 13:40:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306133816-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAXfegxCfvfLwiJT@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

On Mon, Mar 06, 2023 at 01:41:30PM +0100, Jiri Pirko wrote:
> Thu, Mar 02, 2023 at 02:05:06PM CET, mst@redhat.com wrote:
> >The admin virtqueues will be the first interface to issue admin commands.
> >
> >Currently virtio specification defines control virtqueue to manipulate
> >features and configuration of the device it operates on. However,
> >control virtqueue commands are device type specific, which makes it very
> >difficult to extend for device agnostic commands.
> >
> >To support this requirement in a more generic way, this patch introduces
> >a new admin virtqueue interface.
> >
> >We also support more than one admin virtqueue, for QoS and
> >scalability requirements.
> >
> >Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >---
> > admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > content.tex |  7 +++--
> > 2 files changed, 79 insertions(+), 2 deletions(-)
> >
> >diff --git a/admin.tex b/admin.tex
> >index 7e28b77..3ffac2e 100644
> >--- a/admin.tex
> >+++ b/admin.tex
> >@@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> > \field{command_specific_data} and \field{command_specific_result}
> > depends on these structures and is described separately or is
> > implicit in the structure description.
> >+
> >+\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >+
> >+An administration virtqueue of an owner device is used to submit
> >+group administration commands. An owner device can have more
> 
> I admit I'm confused. You introduce a concept of admin virtqueue, which
> sounds quite generic to me, usable in future by much more things than
> "device groups", correct?
> 
> If yes, here you say "group administration commands" which contradics
> that idea. On multiple places the text this patchset introduces
> this very muych tights to groups. Like in struct virtio_admin_cmd
> which contains fields very specific to groups.
> 
> If no, isn't it a mistake as the admin queue should be here to
> handle more than just group commands?

For now, no.

Passing commands to devices themselves is already covered in spec
reasonably well though not in a generic way.

What we lack is passing commands about one device to another device.
E.g. control VFs through PFs.
This is what groups do.
But if we see more uses we can always add them.


I'd rather avoid being too generic though.




> 
> >+than one administration virtqueue.
> >+
> >+If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> >+or more adminstration virtqueues. The number and locations of the
> >+administration virtqueues are exposed by the owner device in a transport
> >+specific manner.
> >+
> >+The driver submits commands by queueing them to an arbitrary
> >+administration virtqueue, and they are processed by the
> >+device in the order in which they are queued. It is the
> >+responsibility of the driver to ensure ordering for commands
> >+placed on different administration virtqueues, because they will
> >+be executed with no order constraints.
> >+
> >+Administration virtqueues are used as follows:
> >+\begin{itemize}
> >+\item The driver submits the command using the \field{struct virtio_admin_cmd}
> >+structure using a buffer consisting of two parts: a device-readable one followed by a
> >+device-writable one.
> >+\item the device-readable part includes fields from \field{opcode}
> >+through \field{command_specific_data}.
> >+\item the device-writeable buffer includes fields from \field{status}
> >+through \field{command_specific_result} inclusive.
> >+\end{itemize}
> >+
> >+For each command, this specification describes a distinct
> >+format structure used for \field{command_specific_data} and
> >+\field{command_specific_result}, the length of these fields
> >+depends on the command.
> >+
> >+However, to ensure forward compatibility
> >+\begin{itemize}
> >+\item drivers are allowed to submit buffers that are longer
> >+than what the device expects
> >+(that is, longer than the length of
> >+\field{opcode} through \field{command_specific_data}).
> >+This allows the driver to maintain
> >+a single format structure even if some structure fields are
> >+unused by the device.
> >+\item drivers are allowed to submit buffers that are shorter
> >+than what the device expects
> >+(that is, shorter than the length of \field{status} through
> >+\field{command_specific_result}). This allows the device to maintain
> >+a single format structure even if some structure fields are
> >+unused by the driver.
> >+\end{itemize}
> >+
> >+The device compares the length of each part (device-readable and
> >+device-writeable) of the buffer as submitted by driver to what it
> >+expects and then silently truncates the structures to either the
> >+length submitted by the driver, or the length described in this
> >+specification, whichever is shorter.  The device silently ignores
> >+any data falling outside the shorter of the two lengths. Any
> >+missing fields are interpreted as set to zero.
> >+
> >+Similarly, the driver compares the used buffer length
> >+of the buffer to what it expects and then silently
> >+truncates the structure to the used buffer length.
> >+The driver silently ignores any data falling outside
> >+the used buffer length reported by the device.  Any missing
> >+fields are interpreted as set to zero.
> >+
> >+This simplifies driver and device implementations since the
> >+driver/device can simply maintain a single large structure (such
> >+as a C structure) for a command and its result. As new versions
> >+of the specification are designed, new fields can be added to the
> >+tail of a structure, with the driver/device using the full
> >+structure without concern for versioning.
> >+>>>>>>> 0edc690... admin: introduce virtio admin virtqueues
> 
> Conflict resolution leftover.
> 
> 
> >diff --git a/content.tex b/content.tex
> >index ffe45c4..c8647c9 100644
> >--- a/content.tex
> >+++ b/content.tex
> >@@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> > \begin{description}
> > \item[0 to 23, and 50 to 127] Feature bits for the specific device type
> > 
> >-\item[24 to 40] Feature bits reserved for extensions to the queue and
> >+\item[24 to 41] Feature bits reserved for extensions to the queue and
> >   feature negotiation mechanisms
> > 
> >-\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> >+\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> > \end{description}
> > 
> > \begin{note}
> >@@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >   that the driver can reset a queue individually.
> >   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> > 
> >+  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> >+  administration virtqueues.
> >+
> > \end{description}
> > 
> > \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> >-- 
> >MST
> >
> >
> >---------------------------------------------------------------------
> >To unsubscribe from this mail list, you must leave the OASIS TC that 
> >generates this mail.  Follow this link to all your TCs in OASIS at:
> >https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

