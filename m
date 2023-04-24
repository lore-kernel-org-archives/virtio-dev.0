Return-Path: <virtio-dev-return-12367-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62234C77B78
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:18:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADF2E41A09
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:18:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D07298642D
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:18:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9022498635B; Mon, 24 Apr 2023 16:18:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CD9B986350
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7SEl3Sq2MGSQs2sZ-2QsEw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353084; x=1684945084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ7dVhGEH0NSJl2iTOX6RvE1s0Hjgj1vz6+FuTr2lYY=;
        b=d0UkMZBRXaknCPiyYZwayRTsiH3BwCy9XRFPxA3k3LldOpRAGzRWNoLiv62Ij9LihP
         weMBkaXvtG+Y6qzLZkRlAsVcOh8YkW7KgqRBgaTPGnO76JQ5mKN2lFDYIpB/1jFv+sY5
         aUAAh/onxaVVvaOliHJnxREmOG4MeMeyAF7b2AwMZd/mtiFc9DAe9NBZHnvsU4soPksp
         8ut8+Mzu+vQb8P9Irm5e/01cTTJq4pvjYEK6uZM+sMhuly/g68Dw7saqWskF6FWrB5Rf
         eY5JkHDrN45ttxb7B28zlGgUPAtsSutWj6NAxCj8kAmrQaZWY+TX+0ffta9bG0lPXnQk
         ae8w==
X-Gm-Message-State: AAQBX9cLBq55GidKt9BWxWecGP5I8nGSNRLXJC0JDgz+bA2/anR6Baxj
	cDRceXElT8J6c9fCqmKjW1k2Gc2Wl4QDgcR6urex1ZSEuFh6aEeA9fVvcul1BAH355s2uorI8aJ
	A0K8Z4bFRWOItpThL6LEI4pH59DBL
X-Received: by 2002:a1c:ed01:0:b0:3f0:a9dc:a369 with SMTP id l1-20020a1ced01000000b003f0a9dca369mr8210592wmh.19.1682353083649;
        Mon, 24 Apr 2023 09:18:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350b5/encR1i8czHQ9MmYRtZiuSpthAqrJy5/T2XX2YrhxFJlu/MHKbemC6l1kb4MZ6sDeHwp4A==
X-Received: by 2002:a1c:ed01:0:b0:3f0:a9dc:a369 with SMTP id l1-20020a1ced01000000b003f0a9dca369mr8210562wmh.19.1682353083198;
        Mon, 24 Apr 2023 09:18:03 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:17:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230424121414-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <f254f6eb0b7ade1aa9892b09539711171a41a02b.1680533760.git.mst@redhat.com>
 <70588b1f-d9d1-e2f1-9023-2d6620169eba@intel.com>
MIME-Version: 1.0
In-Reply-To: <70588b1f-d9d1-e2f1-9023-2d6620169eba@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v11 09/10] admin:
 conformance clauses

On Thu, Apr 06, 2023 at 03:30:56PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 4/3/2023 11:03 PM, Michael S. Tsirkin wrote:
> > Add conformance clauses for admin commands and admin virtqueues.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > typo and wording fixes reported by David
> > clarify cmd list use can be repeated but not in parallel with other
> > commands, and returning same value across uses - comment by Lingshan
> > add conformance clauses for new error codes
> > ---
> >   admin.tex | 227 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 227 insertions(+)
> > 
> > diff --git a/admin.tex b/admin.tex
> > index 9552797..a398c51 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -283,6 +283,150 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >   supporting multiple group types, the list of supported commands
> >   might differ between different group types.
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
> > +any side effects on the device, in particular the device MUST NOT
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
> > +The device MUST validate commands against the list used by
> > +the driver and MUST fail any commands not in the list with
> > +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
> > +and \field{status_qualifier} set to
> > +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
> > +
> > +The list of supported commands reported by the device MUST NOT
> > +shrink (but MAY expand): after reporting a given command as
> > +supported through VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT
> > +later report it as unsupported.  Further, after a given set of
> > +commands has been used (via a successful
> > +VIRTIO_ADMIN_CMD_LIST_USE), then after a device or system reset
> > +the device SHOULD complete successfully any following calls to
> > +VIRTIO_ADMIN_CMD_LIST_USE with the same list of commands; if this
> > +command VIRTIO_ADMIN_CMD_LIST_USE fails after a device or system
> > +reset, the device MUST not fail it solely because of the command
> > +list used.  Failure to do so would interfere with resuming from
> > +suspend and error recovery. Exceptions MAY apply if the system
> > +configuration assures, in some way, that the driver does not
> > +cache the previous value of VIRTIO_ADMIN_CMD_LIST_USE,
> > +such as in the case of a firmware upgrade or downgrade.
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
> > +The driver MAY issue VIRTIO_ADMIN_CMD_LIST_USE any number
> > +of times but MUST NOT issue VIRTIO_ADMIN_CMD_LIST_USE commands
> > +if any other command is currently being processed by the device.
> Please correct me if I misunderstood this,
> IMHO when the driver re-negotiates the features by issuing _USE command,
> the driver can choose to shrink the feature bits and there
> may be some already queued descriptors require the previous negotiated
> feature bits. So I think the driver must make sure the admin queues are
> empty(like all descriptors are marked as used) before it re-negotiating the
> features.

oh so not just processed, queued also. good point.

> Others look good to me.
> > +
> > +The driver SHOULD NOT set bits in device_admin_cmd_opcodes
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
> > +
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
> >   \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >   An administration virtqueue of an owner device is used to submit
> > @@ -357,3 +501,86 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
> >   of the specification are designed, new fields can be added to the
> >   tail of a structure, with the driver/device using the full
> >   structure without concern for versioning.
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
> > +The device MUST initialize \field{status} and
> > +\field{status_qualifier} in \field{struct virtio_admin_cmd}.
> > +
> > +The device MUST process commands on a given administration virtqueue
> > +in the order in which they are queued.
> > +
> > +If multiple administration virtqueues have been configured,
> > +device MAY process commands on distinct virtqueues with
> > +no order constraints.
> > +
> > +If the device sets \field{status} to either VIRTIO_ADMIN_STATUS_EAGAIN
> > +or VIRTIO_ADMIN_STATUS_ENOMEM, then the command MUST NOT
> > +have any side effects, making it safe to retry.
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
> > +
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
> > +
> > +The driver SHOULD retry a command that completed with
> > +\field{status} VIRTIO_ADMIN_STATUS_EAGAIN.
> Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

