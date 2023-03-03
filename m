Return-Path: <virtio-dev-return-11411-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8611AC678D4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DBF1E2AEFF
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCEE6986712
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A326B9863C9; Fri,  3 Mar 2023 00:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89B809866D5
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 00:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bjfyI0zsMZWogbzQIF4zkw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0M3hC93t0KzSYYqXr3hSBUDwm8x/mnSSJmC0BtZZEo=;
        b=WFT/pBpUysFHVSA/somwyHVYeeslIKlmcTbSLFwRMJxUDE2vcwXbGTp/wTBwIecAdb
         nkUUWM0HXLr2VT4xKoPz1MILULxD+F65hkFGYlJ6tsw8TaVFLuk0IODWgStq7ZZjwy9Q
         ZE8QOuh27UX/zncL49U89PPD/7CmX7iRZ24RPgZoJLkn0iKErNa2WlUrMaV0yNhAR14E
         PicOXB3q8CxleqwTF0Dgp3SspOnl3hEcNX5gOgkyVWPEHVstjtQYz3zMZ1jlF9E1Hsf7
         rkgYpQrqyC+EYckI3EjJKHvsBZ/yoMfTZCVA5Nqfni5z922SJ8lvq9Lfxv4Z0RWyr98U
         SeeQ==
X-Gm-Message-State: AO0yUKV9UXsKsrRasrTsq8c73wg6tRW9/tGU+6KqtJFtUzyO/L4fysXO
	i504rchJ4ovIXQle+QKE0rp7tDZy0RwtEuctiq/yfGeRdm2kNcwEcZKpBZ/OuI3gnztF+UDhBHo
	8svVk5LTae2M8AMyGYkG+DgUTLYiJ
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr9568150wmn.9.1677801918926;
        Thu, 02 Mar 2023 16:05:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+7eF8ZYTW2drhU6/LDY4qpzZlIMuGhw0PjHratKQcYK33lN/O+Q4nyUt2TOPxY5SuMXZOBpw==
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr9568126wmn.9.1677801918582;
        Thu, 02 Mar 2023 16:05:18 -0800 (PST)
Date: Thu, 2 Mar 2023 19:05:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302190230-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
MIME-Version: 1.0
In-Reply-To: <20230302204007.GD2554028@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 04/10] admin: introduce virtio admin virtqueues

On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
> On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
> > The admin virtqueues will be the first interface to issue admin commands.
> > 
> > Currently virtio specification defines control virtqueue to manipulate
> > features and configuration of the device it operates on. However,
> > control virtqueue commands are device type specific, which makes it very
> > difficult to extend for device agnostic commands.
> > 
> > To support this requirement in a more generic way, this patch introduces
> > a new admin virtqueue interface.
> 
> Is this referring to the existing virtio-net, virtio-scsi, etc control
> virtqueues?
> 
> I see the admin virtqueue as the virtqueue equivalent to transport
> feature bits. The admin queue does nothing device type-specific (net,
> scsi, etc) and instead focusses on transport and core virtio tasks.
> 
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.

yes this commit log is outdated. referred to original
proposal by Max which also planned to replace cvq.
will update.


> > We also support more than one admin virtqueue, for QoS and
> > scalability requirements.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  content.tex |  7 +++--
> >  2 files changed, 79 insertions(+), 2 deletions(-)
> > 
> > diff --git a/admin.tex b/admin.tex
> > index 7e28b77..3ffac2e 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >  \field{command_specific_data} and \field{command_specific_result}
> >  depends on these structures and is described separately or is
> >  implicit in the structure description.
> > +
> > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> > +
> > +An administration virtqueue of an owner device is used to submit
> > +group administration commands. An owner device can have more
> > +than one administration virtqueue.
> > +
> > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> > +or more adminstration virtqueues. The number and locations of the
> > +administration virtqueues are exposed by the owner device in a transport
> > +specific manner.
> > +
> > +The driver submits commands by queueing them to an arbitrary
> > +administration virtqueue, and they are processed by the
> > +device in the order in which they are queued. It is the
> > +responsibility of the driver to ensure ordering for commands
> > +placed on different administration virtqueues, because they will
> > +be executed with no order constraints.
> 
> Does "they are processed by the device in the order in which they are
> queued" mean only 1 admin command can be running at any given time and
> therefore they will complete in order? This would allow pipelining
> dependent commands but prevent long-running commands because the
> virtqueue is blocked while executing a command.

we have multiple vqs for that.

> > +
> > +Administration virtqueues are used as follows:
> > +\begin{itemize}
> > +\item The driver submits the command using the \field{struct virtio_admin_cmd}
> > +structure using a buffer consisting of two parts: a device-readable one followed by a
> > +device-writable one.
> > +\item the device-readable part includes fields from \field{opcode}
> > +through \field{command_specific_data}.
> > +\item the device-writeable buffer includes fields from \field{status}
> > +through \field{command_specific_result} inclusive.
> > +\end{itemize}
> > +
> > +For each command, this specification describes a distinct
> > +format structure used for \field{command_specific_data} and
> > +\field{command_specific_result}, the length of these fields
> > +depends on the command.
> > +
> > +However, to ensure forward compatibility
> > +\begin{itemize}
> > +\item drivers are allowed to submit buffers that are longer
> > +than what the device expects
> > +(that is, longer than the length of
> > +\field{opcode} through \field{command_specific_data}).
> > +This allows the driver to maintain
> > +a single format structure even if some structure fields are
> > +unused by the device.
> > +\item drivers are allowed to submit buffers that are shorter
> > +than what the device expects
> > +(that is, shorter than the length of \field{status} through
> > +\field{command_specific_result}). This allows the device to maintain
> > +a single format structure even if some structure fields are
> > +unused by the driver.
> > +\end{itemize}
> > +
> > +The device compares the length of each part (device-readable and
> > +device-writeable) of the buffer as submitted by driver to what it
> > +expects and then silently truncates the structures to either the
> > +length submitted by the driver, or the length described in this
> > +specification, whichever is shorter.  The device silently ignores
> > +any data falling outside the shorter of the two lengths. Any
> > +missing fields are interpreted as set to zero.
> > +
> > +Similarly, the driver compares the used buffer length
> > +of the buffer to what it expects and then silently
> > +truncates the structure to the used buffer length.
> > +The driver silently ignores any data falling outside
> > +the used buffer length reported by the device.  Any missing
> > +fields are interpreted as set to zero.
> > +
> > +This simplifies driver and device implementations since the
> > +driver/device can simply maintain a single large structure (such
> > +as a C structure) for a command and its result. As new versions
> > +of the specification are designed, new fields can be added to the
> > +tail of a structure, with the driver/device using the full
> > +structure without concern for versioning.
> > +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues
> 
> A merge conflict line crept into the patch?

yes. I fixed it I thought but somehow it's still there :(

> > diff --git a/content.tex b/content.tex
> > index ffe45c4..c8647c9 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> >  \begin{description}
> >  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
> >  
> > -\item[24 to 40] Feature bits reserved for extensions to the queue and
> > +\item[24 to 41] Feature bits reserved for extensions to the queue and
> >    feature negotiation mechanisms
> >  
> > -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> > +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> >  \end{description}
> >  
> >  \begin{note}
> > @@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >    that the driver can reset a queue individually.
> >    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> >  
> > +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> > +  administration virtqueues.
> > +
> >  \end{description}
> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > -- 
> > MST
> > 



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

