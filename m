Return-Path: <virtio-dev-return-11509-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B5AC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 60B302AC56
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B9A5986702
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:58:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 16B3C9866EF; Wed,  8 Mar 2023 11:58:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED8329866F3
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 11:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: j3mlhZugNN-kyER5lJDqgQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le+WcZjpAuk6RywIZ5aIBzjTd6uUNnCVzvtfOt0wKMY=;
        b=DlLZKhdt9GJ1aQc+gAFBtwlsoz59Vbmju7Hmj35RxzKyRH/289QrBH9OSD8EFTPoHW
         DGE/DaCkciIkMJ65PTRwl3q0bHN0RNMM5ZSdhUcipO/0jeXMRjCd+JQkaHn7WJd8c7IT
         mFxysYxHzCnBhiIj1IRx9FAUV7N/xM/J7ICieLE7ufZAh5RSxEpyiwiCkIN4pvcZXTZU
         a3HTPSLbhfbExYK76fo9tqPkQXnh/w2NLGiTG8CmpIN0bfaKTS8lRWw/dfRGreuaofOO
         8ARKWfllj2k8Fvhv9l/TnuVA+nfrtuuB0ZE91Fu+ZDWeILhSEU3AlNB6tjl4EyA6wOdV
         LXfw==
X-Gm-Message-State: AO0yUKUYJiE7wKufHmgGHQeDckjiJhsapNanwdePCPL60Bm7RE8kgbnT
	CgY4ufg0fnyoSTMue6ZtdUvC00QuoTuUMv7KGT7e3p4hyEy86QgiUevGmAMpUrAq16RhckVcrgY
	0S5HzCP6yXEML0gHZn2zthqQuabmR
X-Received: by 2002:a17:906:135a:b0:8b1:3038:e81f with SMTP id x26-20020a170906135a00b008b13038e81fmr18357721ejb.50.1678276686594;
        Wed, 08 Mar 2023 03:58:06 -0800 (PST)
X-Google-Smtp-Source: AK7set8FlsHK3STW42/gEyA/gtusjLplT6aZ3qOwd2yFn3uxBGKRaSUxur7IkpS8LC/OB+LEH5gMQQ==
X-Received: by 2002:a17:906:135a:b0:8b1:3038:e81f with SMTP id x26-20020a170906135a00b008b13038e81fmr18357704ejb.50.1678276686235;
        Wed, 08 Mar 2023 03:58:06 -0800 (PST)
Date: Wed, 8 Mar 2023 06:58:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308065526-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <m27cvszuta.fsf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 09/10] admin: conformance clauses

On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Add conformance clauses for admin commands and admin virtqueues.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  admin.tex | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 215 insertions(+), 1 deletion(-)
> >
> > diff --git a/admin.tex b/admin.tex
> > index 1172054..6c4f79c 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -251,6 +251,145 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >  supporting multiple group types, the list of supported commands
> >  might differ between different group types.
> >  
> > +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> > +
> > +The device MUST validate \field{opcode}, \field{group_type} and
> > +\field{group_member_id}, and if any of these has an invalid or
> > +unsupported value, set \field{status} to
> > +VIRTIO_ADMIN_STATUS_EINVAL and set \field{status_qualifier}
> > +accordingly:
> > +\begin{itemize}
> > +\item if \field{group_type} is invalid, \field{status_qualifier}
> > +	MUST be set to VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
> > +\item otherwise, if \field{opcode} is invalid,
> > +	\field{status_qualifier} MUST be set to
> > +	VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE;
> > +\item otherwise, if \field{group_member_id} is used by the
> > +	specific command and is invalid, \field{status_qualifier} MUST be
> > +	set to VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER.
> > +\end{itemize}
> > +
> > +If a command completes successfully, the device MUST set
> > +\field{status} to VIRTIO_ADMIN_STATUS_OK.
> > +
> > +If a command fails, the device MUST set
> > +\field{status} to a value different from VIRTIO_ADMIN_STATUS_OK.
> > +
> > +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
> > +device state MUST NOT change, that is the command MUST NOT have
> > +any side effects on the device, in particular the device MUST not
> 
> MUST NOT

/me nods

> > +enter an error state as a result of this command.
> > +
> > +If a command fails, the device state generally SHOULD NOT change,
> > +as far as possible.
> > +
> > +The device MAY enforce additional restrictions and dependencies on
> > +opcodes used by the driver and MAY fail the command
> > +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
> > +if the list of commands used violate internal device dependencies.
> > +
> > +If the device supports multiple group types, commands for each group
> > +type MUST operate independently of each other, in particular,
> > +the device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY
> > +for different group types.
> > +
> > +After reset, if the device supports a given group type
> > +and before receiving VIRTIO_ADMIN_CMD_LIST_USE for this group type
> > +the device MUST assume
> > +that the list of legal commands used by the driver consists of
> > +the two commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> > +
> > +After completing VIRTIO_ADMIN_CMD_LIST_USE successfully,
> > +the device MUST set the list of legal commands used by the driver
> > +to the one supplied in \field{command_specific_data}.
> > +
> > +The device MUST set the list of legal commands used by the driver
> > +to the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.
> 
> Are these last two paragraphs not saying the same thing?


They are!

> > +The device MUST validate commands against the list used by
> > +the driver and MUST fail any commands not in the list with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> > +
> > +The list of supported commands MUST NOT shrink (but MAY expand):
> > +after reporting a given command as supported through
> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> > +as unsupported.  Further, after a given set of commands has been
> > +used (via a successful VIRTIO_ADMIN_CMD_LIST_USE), then after a
> > +device or system reset the device SHOULD complete successfully
> > +any following calls to VIRTIO_ADMIN_CMD_LIST_USE with the same
> > +list of commands; if this command VIRTIO_ADMIN_CMD_LIST_USE fails
> > +after a device or system reset, the device MUST not fail it
> > +solely because of the command list used.  Failure to do so would
> > +interfere with resuming from suspend and error recovery.
> > +
> > +When processing a command with the SR-IOV group type,
> > +if the device does not have an SR-IOV Extended Capability or
> > +if \field{VF Enable} is clear
> > +then the device MUST fail all commands with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
> > +\field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
> > +otherwise, if \field{group_member_id} is not
> > +between $1$ and \field{NumVFs} inclusive,
> > +the device MUST fail all commands with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
> > +\field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER;
> > +\field{NumVFs}, \field{VF Migration Capable}  and
> > +\field{VF Enable} refer to registers within the SR-IOV Extended
> > +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
> > +
> > +The driver MAY discover whether device supports a specific group type
> > +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
> > +\field{group_type}.
> > +
> > +The driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE
> > +and wait for it to be completed with status
> > +VIRTIO_ADMIN_STATUS_OK before issuing any commands
> > +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
> > +and VIRTIO_ADMIN_CMD_LIST_USE).
> > +
> > +The driver SHOULD NOT set bits in device_admin_cmds
> > +if it is not familiar with how the command opcode
> > +is used, as dependencies between command opcodes might exist.
> > +
> > +The driver MUST NOT request (via VIRTIO_ADMIN_CMD_LIST_USE)
> > +the use of any commands not previously reported as
> > +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
> > +
> > +The driver MUST NOT use any commands for a given group type
> > +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
> > +list of command opcodes and group type.
> > +
> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> > +with respective bits cleared in \field{command_specific_data}.
> 
> This runs contrary to the assertion "The list of supported commands MUST
> NOT shrink", given that a driver is told to assume that
> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
> commands initially available.

Commands are still available just disabled, the meaning of
"MUST NOT shrink" is clarified by the following:

	> > +after reporting a given command as supported through
	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
	> > +as unsupported.
I will stick an "i.e." there to make it hopefully clearer.



> 
> > +The driver MUST handle a command error with a reserved \field{status}
> > +value in the same way as \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +(except possibly for different error reporting/diagnostic messages).
> > +
> > +The driver MUST handle a command error with a reserved
> > +\field{status_qualifier} value in the same way as
> > +\field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND (except possibly for
> > +different error reporting/diagnostic messages).
> > +
> > +When sending commands with the SR-IOV group type,
> > +the driver specify a value for \field{group_member_id}
> > +between $1$ and \field{NumVFs} inclusive,
> > +the driver MUST also make sure that as long as any such command
> > +is outstanding, \field{VF Migration Capable} is clear and
> > +\field{VF Enable} is set;
> > +\field{NumVFs}, \field{VF Migration Capable}  and
> > +\field{VF Enable} refer to registers within the SR-IOV Extended
> > +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> > +
> >  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >  
> >  An administration virtqueue of an owner device is used to submit
> > @@ -323,4 +462,79 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
> >  of the specification are designed, new fields can be added to the
> >  tail of a structure, with the driver/device using the full
> >  structure without concern for versioning.
> > ->>>>>>> 0edc690... admin: introduce virtio admin virtqueues
> 
> Oh, here is where it got removed :-)

/me blushes

> > +
> > +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> > +
> > +The device MUST support device-readable and device-writeable buffers
> > +shorter than described in this specification, by
> > +\begin{enumerate}
> > +\item acting as if any data that would be read outside the
> > +device-readable buffers is set to zero, and
> > +\item discarding data that would be written outside the
> > +specified device-writeable buffers.
> > +\end{enumerate}
> > +
> > +The device MUST support device-readable and device-writeable buffers
> > +longer than described in this specification, by
> > +\begin{enumerate}
> > +\item ignoring any data in device-readable buffers outside
> > +the expected length, and
> > +\item only writing the expected structure to the device-writeable
> > +buffers, ignoring any extra buffers, and reporting the
> > +actual length of data written, in bytes,
> > +as buffer used length.
> > +\end{enumerate}
> > +
> > +The device SHOULD initialize the device-writeable buffer
> > +up to the length of the structure described by this specification or
> > +the length of the buffer supplied by the driver (even if the buffer is
> > +all set to zero), whichever is shorter.
> > +
> > +The device MUST NOT fail a command solely because the buffers
> > +provided are shorter or longer than described in this
> > +specification.
> > +
> > +The device MUST initialize the device-writeable part of
> > +\field{struct virtio_admin_cmd} that is a multiple of 64 bit in
> > +size.
> > +
> > +The device MUST initialize \field{status} in \field{struct
> > +virtio_admin_cmd}.
> > +
> > +The device MUST process commands on a given administration virtqueue
> > +in the order in which they are queued.
> > +
> > +If multiple administration virtqueues have been configured,
> > +device MAY process commands on distinct virtqueues with
> > +no order constraints.
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
> > +
> > +The driver MAY supply device-readable or device-writeable parts
> > +of \field{struct virtio_admin_cmd} that are longer than described in
> > +this specification.
> > +
> > +The driver SHOULD supply device-readable part of
> > +\field{struct virtio_admin_cmd} that is at least as
> > +large as the structure described by this specification
> > +(even if the structure is all set to zero).
> > +
> > +The driver MUST supply both device-readable or device-writeable parts
> > +of \field{struct virtio_admin_cmd} that are a multiple of 64 bit
> > +in length.
> 
> This addresses my question on a previous patch.
> 
> > +The device MUST supply both device-readable or device-writeable parts
> > +of \field{struct virtio_admin_cmd} that are larger than zero in
> > +length. However, \field{command_specific_data} and
> > +\field{command_specific_result} MAY be zero in length, unless
> > +specified otherwise for the command.
> > +
> > +The driver MUST NOT assume that the device will initialize the whole
> > +device-writeable part of \field{struct virtio_admin_cmd} as described in the specification; instead,
> > +the driver MUST act as if the structure
> > +outside the part of the buffer used by the device
> > +is set to zero.
> > +
> > +If multiple administration virtqueues have been configured,
> > +the driver MUST ensure ordering for commands
> > +placed on different administration virtqueues.
> > -- 
> > MST
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> -- 
> Music has magic, it's good clear syncopation.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

