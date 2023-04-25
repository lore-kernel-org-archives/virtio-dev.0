Return-Path: <virtio-dev-return-12397-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00EC77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D17129FD2
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FB7F98644E
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:20:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 334739863D7; Tue, 25 Apr 2023 06:20:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 178B9986411
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 06:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oVTKAnyeP8mCGPW8o0G8uA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682403608; x=1684995608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqBeHguuwW7PXihIGiy2PWo40JUXji1VJaKA79r7toE=;
        b=hNX2zrf1YCIZ5m6hKz3VTANzCK78XZaDgeJy7oJ3mrS2yjeTvIUfzT261XzKAHAJUR
         SdzjksKaky3Ye3dgUCrsiQA/rsyGOaxVjYh5Y3DbHdB0kkXizF7ZQYKIcnqhbAKO87bf
         DO6itMAb9ZtTj9YJOkQedtyRJjS0fyhQ+MR2YRvI0GIKA6r2QNv3SSsTwr8sFCADmkSe
         WDIq4Clw609PSqQ6QoqfkaX/9b966x848SmtuC9bOPYD3MJm6FzsLCMyZnKmcQvaLPfx
         7drbLouO8Wc+DiGDxBxaCrPVsQjD2HG6acikO8SHlkvq3elgqhT7FLYaYCCWICPLkjo2
         TLpA==
X-Gm-Message-State: AAQBX9flAcvJNFZ1VZkJ6e2wRAi6S/LoHoU1NpPRegTP17hCawvy4n4g
	Jiw6EI5ZPYT1fCYiaMv3KVIYHKX9RlAip3XcYyLPidzboPg6c70nRLuXCS1eIo+6LUrXd8ECt2u
	4Tb4Ghvo3hp0iUr7i58nmPbbwqmtK
X-Received: by 2002:adf:ce0c:0:b0:2f2:1fb6:7b0c with SMTP id p12-20020adfce0c000000b002f21fb67b0cmr11083660wrn.49.1682403607897;
        Mon, 24 Apr 2023 23:20:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350a4GlFDL33t/x5sWfnuGL8/9uadJe0QplHqhh3EmeBMFRY3uIZ/J6VIjSOJWQZUvemgCM9bfw==
X-Received: by 2002:adf:ce0c:0:b0:2f2:1fb6:7b0c with SMTP id p12-20020adfce0c000000b002f21fb67b0cmr11083632wrn.49.1682403607514;
        Mon, 24 Apr 2023 23:20:07 -0700 (PDT)
Date: Tue, 25 Apr 2023 02:20:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230425020925-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 03/10] admin: introduce group administration commands

On Mon, Apr 24, 2023 at 06:07:12PM -0400, Parav Pandit wrote:
> 
> 
> On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> > This introduces a general structure for group administration commands,
> > used to control device groups through their owner.
> > 
> > Following patches will introduce specific commands and an interface for
> > submitting these commands to the owner.
> > 
> > Note that the commands are focused on controlling device groups:
> > this is why group related fields are in the generic part of
> > the structure.
> 
> Below paragraph is no longer applies as we already discussed more use cases
> of the AQ such as accessing the PCI VF's legacy config space registers.
> Please drop below paragraph.

Look - at one point you want commit log to record design process,
an another you turn around and ask me to drop it.
I feel like keeping this around frankly. Maybe I will add
a sentence or two along the lines of "Note that nothing limits us from
extending this down the road though - but let's focus
on what we already know for now".

This extreme focus on commit log is poinless anyway - it makes
much more sense for code since commit log describes the
change in english. Here the whole change is english anyway.

> > Without this the admin vq would become a "whatever" vq which does not do
> > anything specific at all, just a general transport like thing.
> > I feel going this way opens the design space to the point where
> > we no longer know what belongs in e.g. config space
> > what in the control q and what in the admin q.
> > As it is, whatever deals with groups is in the admin q; other
> > things not in the admin q.
> > 
> 
> A PF can use same or different AQ with a new struct
> virtio_legacy_register_access with a different opcode range.

We'll get to that bridge and we'll cross it, the proposal is not
on list even yet. I actually think that yes, you need
it in a separate function. If PF is passed through to guest
then PF can not also safely DMA into host memory.
Alternatively, we could use an MMIO based mechanism for
admin commands. And maybe that would be a good fit.

> AQ doesn't replace the control vq, so that part description is fine.
> 
> > There are specific exceptions such as query but that's an exception that
> > proves the rule ;)
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> > 
> > changes since v11:
> > 	acks by Stefan and Lingshan
> > 
> > changes since v10:
> > 	explain the role of status vs status_qualifier, addresses
> > 		multiple comments
> > 	add more status values and appropriate qualifiers,
> > 		as suggested by Parav
> > 	clarify reserved command opcodes as suggested by Stefan
> > 	better formatting for ranges, comment by Jiri
> > 	make sure command-specific-data is a multiple of qword,
> > 	so things are aligned, suggested by Jiri
> > 	add Q_OK qualifier for success
> > ---
> >   admin.tex        | 121 +++++++++++++++++++++++++++++++++++++++++++++++
> >   introduction.tex |   3 ++
> >   2 files changed, 124 insertions(+)
> > 
> > diff --git a/admin.tex b/admin.tex
> > index 05d506a..d6042e4 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -60,4 +60,125 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
> >   PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> >   \end{description}
> > +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> > +The driver sends group administration commands to the owner device of
> > +a group to control member devices of the group.
> > +This mechanism can
> > +be used, for example, to configure a member device before it is
> > +initialized by its driver.
> > +\footnote{The term "administration" is intended to be interpreted
> > +widely to include any kind of control. See specific commands
> > +for detail.}
> > +
> > +All the group administration commands are of the following form:
> > +
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd {
> > +        /* Device-readable part */
> > +        le16 opcode;
> > +        /*
> > +         * 1       - SR-IOV
> > +         * 2-65535 - reserved
> > +         */
> > +        le16 group_type;
> > +        /* unused, reserved for future extensions */
> > +        u8 reserved1[12];
> > +        le64 group_member_id;
> > +        le64 command_specific_data[];
> > +
> > +        /* Device-writable part */
> > +        le16 status;
> > +        le16 status_qualifier;
> > +        /* unused, reserved for future extensions */
> > +        u8 reserved2[4];
> > +        u8 command_specific_result[];
> > +};
> > +\end{lstlisting}
> > +
> > +For all commands, \field{opcode}, \field{group_type} and if
> > +necessary \field{group_member_id} and \field{command_specific_data} are
> > +set by the driver, and the owner device sets \field{status} and if
> > +needed \field{status_qualifier} and
> > +\field{command_specific_result}.
> > +
> > +Generally, any unused device-readable fields are set to zero by the driver
> > +and ignored by the device.  Any unused device-writeable fields are set to zero
> > +by the device and ignored by the driver.
> > +
> > +\field{opcode} specifies the command. The valid
> > +values for \field{opcode} can be found in the following table:
> > +
> > +\begin{tabular}{|l|l|}
> > +\hline
> > +opcode & Name & Command Description \\
> > +\hline \hline
> > +0x0000 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> > +\hline
> > +0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
> > +\hline
> > +\end{tabular}
> > +
> > +The \field{group_type} specifies the group type identifier.
> > +The \field{group_member_id} specifies the member identifier within the group.
> > +See section \ref{sec:Introduction / Terminology / Device group}
> > +for the definition of the group type identifier and group member
> > +identifier.
> > +
> > +The \field{status} describes the command result and possibly
> > +failure reason at an abstract level, this is appropriate for
> > +forwarding to applications. The \field{status_qualifier} describes
> > +failures at a low virtio specific level, as appropriate for debugging.
> > +The following table describes possible \field{status} values;
> > +to simplify common implementations, they are intentionally
> > +matching common \hyperref[intro:errno]{Linux error names and numbers}:
> > +
> > +\begin{tabular}{|l|l|l|}
> > +\hline
> > +Status (decimal) & Name & Description \\
> > +\hline \hline
> > +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> > +\hline
> > +11   & VIRTIO_ADMIN_STATUS_EAGAIN    & try again \\
> > +\hline
> > +12   & VIRTIO_ADMIN_STATUS_ENOMEM    & insufficient resources \\
> > +\hline
> > +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> > +\hline
> > +other   & -    & group administration command error  \\
> > +\hline
> > +\end{tabular}
> > +
> > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qualifier}
> > +is reserved and set to zero by the device.
> > +
> > +The following table describes possible \field{status_qualifier} values:
> > +\begin{tabular}{|l|l|l|}
> > +\hline
> > +Status & Name & Description \\
> > +\hline \hline
> > +0x00   & VIRTIO_ADMIN_STATUS_Q_OK               & used with VIRTIO_ADMIN_STATUS_OK  \\
> > +\hline
> > +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND  & command error: no additional information  \\
> > +\hline
> > +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE   & unsupported or invalid \field{opcode}  \\
> > +\hline
> > +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> > +\hline
> > +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
> > +\hline
> > +0x05   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER   & unsupported or invalid \field{group_member_id} \\
> > +\hline
> > +0x06   & VIRTIO_ADMIN_STATUS_Q_NORESOURCE       & out of internal resources: ok to retry \\
> > +\hline
> > +0x07   & VIRTIO_ADMIN_STATUS_Q_TRYAGAIN         & command blocks for too long: should retry \\
> > +\hline
> > +0x08-0xFFFF   & -    & reserved for future use \\
> > +\hline
> > +\end{tabular}
> > +
> > +Each command uses a different \field{command_specific_data} and
> > +\field{command_specific_result} structures and the length of
> > +\field{command_specific_data} and \field{command_specific_result}
> > +depends on these structures and is described separately or is
> > +implicit in the structure description.
> > diff --git a/introduction.tex b/introduction.tex
> > index 287c5fc..b7155bf 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -68,6 +68,9 @@ \section{Normative References}\label{sec:Normative References}
> >   	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
> >   	Linux FUSE interface,
> >   	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
> > +	\phantomsection\label{intro:errno}\textbf{[errno]} &
> > +	Linux error names and numbers,
> > +	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/asm-generic/errno-base.h}\\
> Thanks for fixing this link. Missing in commit log changes for v12.

Sorry.

> Hopefully after b4 integration, this will be smooth.

not sure what that has to do with it.

> >           \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
> >           eMMC Electrical Standard (5.1), JESD84-B51,
> >           \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf}\\
> 
> Other than commit log change,
> Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

