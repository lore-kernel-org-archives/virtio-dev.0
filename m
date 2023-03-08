Return-Path: <virtio-dev-return-11513-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2684FC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 874FD41A05
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80334986705
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7260F9866EF; Wed,  8 Mar 2023 12:03:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 602B09866F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 12:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8JmefY15NZiVyczbxAd7ZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCO/8frcPDT9V8sQjkwGeU6d734KlF0GSCdc4hbMdZU=;
        b=JjPaZCRhvK0qKKpv9/jwZNTNgiX+sB9xfidB1Sm+zF/WZkL4EIe+HKyF7OUgBzpUvW
         ovZqmWjDbtZxSJPqLFX4J9+SuluqQ2ROY3yzZvU+Pi05A7St2c2r9AC0YKLIfSVyRCeF
         SlQ9c2rMZviWkCh/JRA0V+ob8OHLGZbVsNdAq/IewBosl8x38w+iirhTuKBFHDAidUGb
         34avz6pLgVbJh9PGC2q1sSoyfTjK49fN5VeB6USQLd09QIW79Aay5XZwCXpszTQ/0uza
         VGpIGiiiaDePiSLru71NQfR3BGxHOLsQLc5VMD87n71UKdkvXjh/f8J/x4Tc2uDKR9Qr
         KGPg==
X-Gm-Message-State: AO0yUKVmUZS9mp7jCeK4ANx3v8GQLukxjkf20WpKhFG/nCzEJMOXXGUy
	oO3KeV+h5WIvR3tOproFhASGEAEMwqnnbHcf6GIQbnq+9fMYGmT/MgA6Y82efWevlG4vmRYztNq
	hpx3zBDsbqeeJyGFmPGlBCNPvVN5M
X-Received: by 2002:a17:907:c08b:b0:8ae:b083:6ceb with SMTP id st11-20020a170907c08b00b008aeb0836cebmr20617367ejc.72.1678276989089;
        Wed, 08 Mar 2023 04:03:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8ljxUf/WJQlmJ3b85B8kLsNyZIJww0dY3vLmcZR+v0YNb9scgrN1D+8fCvT57X8Wklvms3rg==
X-Received: by 2002:a17:907:c08b:b0:8ae:b083:6ceb with SMTP id st11-20020a170907c08b00b008aeb0836cebmr20617332ejc.72.1678276988793;
        Wed, 08 Mar 2023 04:03:08 -0800 (PST)
Date: Wed, 8 Mar 2023 07:03:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308070015-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <20230302201011.GB2554028@fedora>
 <20230302185214-mutt-send-email-mst@kernel.org>
 <20230303131337.GA2866370@fedora>
 <20230303081515-mutt-send-email-mst@kernel.org>
 <20230303202314.GB2901137@fedora>
 <ZAcgp1UqrXQqLdVK@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAcgp1UqrXQqLdVK@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group
 administration commands

On Tue, Mar 07, 2023 at 12:31:51PM +0100, Jiri Pirko wrote:
> Fri, Mar 03, 2023 at 09:23:14PM CET, stefanha@redhat.com wrote:
> >On Fri, Mar 03, 2023 at 08:18:43AM -0500, Michael S. Tsirkin wrote:
> >> On Fri, Mar 03, 2023 at 08:13:37AM -0500, Stefan Hajnoczi wrote:
> >> > On Thu, Mar 02, 2023 at 06:57:24PM -0500, Michael S. Tsirkin wrote:
> >> > > On Thu, Mar 02, 2023 at 03:10:11PM -0500, Stefan Hajnoczi wrote:
> >> > > > On Thu, Mar 02, 2023 at 08:05:02AM -0500, Michael S. Tsirkin wrote:
> >> > > > > This introduces a general structure for group administration commands,
> >> > > > > used to control device groups through their owner.
> >> > > > > 
> >> > > > > Following patches will introduce specific commands and an interface for
> >> > > > > submitting these commands to the owner.
> >> > > > > 
> >> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> > > > > ---
> >> > > > >  admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++++++++
> >> > > > >  introduction.tex |   3 ++
> >> > > > >  2 files changed, 111 insertions(+)
> >> > > > > 
> >> > > > > diff --git a/admin.tex b/admin.tex
> >> > > > > index 3dc47be..7e28b77 100644
> >> > > > > --- a/admin.tex
> >> > > > > +++ b/admin.tex
> >> > > > > @@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
> >> > > > >  PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> >> > > > >  \end{description}
> >> > > > >  
> >> > > > > +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> >> > > > >  
> >> > > > > +The driver sends group administration commands to the owner device of
> >> > > > 
> >> > > > I notice that the terminology is simply "the driver". "Owner driver"
> >> > > > and "group member driver" might be clearer because there will be two
> >> > > > (possibly different) drivers involved.
> >> > > 
> >> > > Hmm I don't really want to repeat owner everywhere.
> >> > > I will clarify that in this section simple "driver" and "device" are
> >> > > owner, "member device" and "member driver" is always called explicitly.
> >> > 
> >> > Sounds good.
> >> > 
> >> > > > > +a group to control member devices of the group.
> >> > > > > +This mechanism can
> >> > > > > +be used, for example, to configure a member device before it is
> >> > > > > +initialized by its driver.
> >> > > > > +\footnote{The term "administration" is intended to be interpreted
> >> > > > > +widely to include any kind of control. See specific commands
> >> > > > > +for detail.}
> >> > > > > +
> >> > > > > +All the group administration commands are of the following form:
> >> > > > > +
> >> > > > > +\begin{lstlisting}
> >> > > > > +struct virtio_admin_cmd {
> >> > > > > +        /* Device-readable part */
> >> > > > > +        le16 opcode;
> >> > > > > +        /*
> >> > > > > +         * 1 - SR-IOV
> >> > > > > +         * 2 - 65535 reserved
> >> > > > > +         */
> >> > > > > +        le16 group_type;
> >> > > > > +        /* unused, reserved for future extensions */
> >> > > > > +        u8 reserved1[12];
> >> > > > > +        le64 group_member_id;
> >> > > > > +        u8 command_specific_data[];
> >> > > > > +
> >> > > > > +        /* Device-writable part */
> >> > > > > +        le16 status;
> >> > > > > +        le16 status_qualifier;
> >> > > > > +        /* unused, reserved for future extensions */
> >> > > > > +        u8 reserved2[4];
> >> > > > > +        u8 command_specific_result[];
> >> > > > > +};
> >> > > > > +\end{lstlisting}
> >> > > > > +
> >> > > > > +For all commands, \field{opcode}, \field{group_type} and if
> >> > > > > +necessary \field{group_member_id} and \field{command_specific_data} are
> >> > > > > +set by the driver, and the owner device sets \field{status} and if
> >> > > > > +needed \field{status_qualifier} and
> >> > > > > +\field{command_specific_result}.
> >> > > > > +
> >> > > > > +Generally, any unused device-readable fields are set to zero by the driver
> >> > > > > +and ignored by the device.  Any unused device-writeable fields are set to zero
> >> > > > > +by the device and ignored by the driver.
> >> > > > > +
> >> > > > > +\field{opcode} specifies the command. The valid
> >> > > > > +values for \field{opcode} can be found in the following table:
> >> > > > > +
> >> > > > > +\begin{tabular}{|l|l|}
> >> > > > > +\hline
> >> > > > > +opcode & Name & Command Description \\
> >> > > > > +\hline \hline
> >> > > > > +0x0000 - 0x7FFF & - &  Group administration commands    \\
> >> > > > > +\hline
> >> > > > > +0x8000 - 0xFFFF & - & Reserved    \\
> >> > > > > +\hline
> >> > > > > +\end{tabular}
> >> > > > 
> >> > > > I thought all commands are "group administration commands" but this
> >> > > > table makes it look like they are just a subset (0x0000 - 0x7FFF) of
> >> > > > group administration commands, which is a paradox.
> >> > > 
> >> > > Well the rest are reserved, maybe we will have more command types who
> >> > > knows. No?
> >> > 
> >> > I see. Does that mean the reserved commands don't need to be in the same
> >> > format as struct virtio_admin_cmd?
> >> 
> >> I am not good in predicting future ...
> >> 
> >> > The entire section is called "Group administration commands" but I get
> >> > the impression it's talking both about admin virtqueue commands in
> >> > general and specifically about group administration commands.
> >> > 
> >> > Is it possible to structure this as follows:
> >> > 
> >> >   Admin Commands
> >> >     ...common stuff...
> >> >     Group Administration Commands (0x0000-0x7fff)
> >> >       ...specific to group administration commands...
> >> >     Reserved (0x8000-0xffff)
> >> 
> >> What if I just write it like this:
> >> 
> >> 
> >> > > > > +\hline \hline
> >> > > > > +0x0000 - 0x7FFF & - &  commands using struct virtio_admin_cmd    \\
> >> > > > > +\hline
> >> > > > > +0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
> >> 
> >> 
> >> will this address the comment?
> >
> >Yes, thanks.
> 
> What is the reason for having this table? I fail to see it.

I think it's more a place-holder table in which follow-up patches
add entries. I'll check and see if we can get rid of it.


> 
> >
> >Stefan
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

