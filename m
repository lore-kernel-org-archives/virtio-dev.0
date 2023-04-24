Return-Path: <virtio-dev-return-12366-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD0C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:13:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 674592AEDE
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:13:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D7A598640F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:13:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 50B9A986367; Mon, 24 Apr 2023 16:13:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B18A986364
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kiHiSRUkMsO7Mr0ekcX4fA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352792; x=1684944792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZVpOVLLqWljOaeFbHfykRW3dtmJjHCT26RgxRobOWk=;
        b=hTnmFoF/R5FcA0bR4n4985eoWEIWlLMCLM3b+kc6TFjWGUcp/pJA2TZ4qoc7efvZ6O
         Hj0Hi6doW0d7hA+HBuZbU8wCG64YZt4HXZAp1+QuTR+h7Tm6vmwTBOqbBPKC9WNpDLEE
         9wRXIGkg95wJYqb1zSBqD8wbmCWMNAgHDU6pkZVKfWLCnlgEe4Qfy5W9S5Knx2wzS3aQ
         BFLgBcTzRsbV/UiGE0awopYgpH1XSiqc6Hfrh9akVTkYn3ckqAHqTl7RJ9N9puFWz/g2
         nSEYiQ47SqY6Vb2810ALn34Pv5P9BRc/41S83Khc4V+ujniIyOkCPY3gUsETMIFFXFBB
         g/dw==
X-Gm-Message-State: AAQBX9dp7P8XXXS3MyF/PMuPnOgp3gwYyTjtIB2gpeuCLZv13mmdJlam
	A5GSssCdpb+R1VBE21C4fctv09/3cY0rq8m8EWBPga42Gi9H4qimM8V+DXCXB25YyP89AllEXcp
	5Esflz6Oc3NDEL3t1uJ64KkCCe6vB
X-Received: by 2002:adf:e411:0:b0:2f4:77e9:997c with SMTP id g17-20020adfe411000000b002f477e9997cmr9690638wrm.52.1682352792618;
        Mon, 24 Apr 2023 09:13:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDi0AKzc2rdipMiW4HU7do9ct5jtq68b5Qj7RVNhVCaztn3U24eVAl72a8ydAKfcl9hVyQwg==
X-Received: by 2002:adf:e411:0:b0:2f4:77e9:997c with SMTP id g17-20020adfe411000000b002f477e9997cmr9690612wrm.52.1682352792272;
        Mon, 24 Apr 2023 09:13:12 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:13:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230424121013-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
 <74a52ec2-da51-d739-176f-84e4357d9da6@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <74a52ec2-da51-d739-176f-84e4357d9da6@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v11 08/10] admin: command list
 discovery

On Thu, Apr 06, 2023 at 12:27:36AM -0400, Parav Pandit wrote:
> 
> On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> > Add commands to find out which commands does each group support,
> > as well as enable their use by driver.
> > This will be especially useful once we have multiple group types.
> > 
> > An alternative is per-type VQs. This is possible but will
> > require more per-transport work. Discovery through the vq
> > helps keep things contained.
> > 
> > e.g. lack of support for some command can switch to a legacy mode
> > 
> Above description about legacy is not clear. what is legacy mode in context
> of admin vq?
> > note that commands are expected to be avolved by adding new
> s/to be avolved/to evolve/
> 
> > fields to command specific data at the tail, so
> > we generally do not need feature bits for compatibility.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > dropped S.O.B by Max
> > explain in commit log how commands will evolve, comment by Stefan
> > replace will use with is capable of use, comment by Stefan
> > typo fix reported by David and Lingshan
> > rename cmds to cmd_opcodes suggested by Jiri
> > list group_type explicitly in command description suggested by Jiri
> > clarify how can device not support some commands
> > always say group administration commands, comment by Jiri
> > ---
> >   admin.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 101 insertions(+), 1 deletion(-)
> > 
> > diff --git a/admin.tex b/admin.tex
> > index f201bcd..9552797 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -113,7 +113,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >   \hline
> >   opcode & Name & Command Description \\
> >   \hline \hline
> > -0x0000 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> > +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
> > +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> > +0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> >   \hline
> >   0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
> >   \hline
> > @@ -183,6 +185,104 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >   depends on these structures and is described separately or is
> >   implicit in the structure description.
> > +Before sending any group administration commands to the device, the driver
> > +needs to communicate to the device which commands it is going to
> > +use. Initially (after reset), only two commands are assumed to be used:
> > +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> > +
> > +Before sending any other commands for any member of a specific group to
> > +the device, the driver queries the supported commands via
> > +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it is
> > +capable of using via VIRTIO_ADMIN_CMD_LIST_USE.
> > +
> > +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> > +VIRTIO_ADMIN_CMD_LIST_USE
> > +both use the following structure describing the
> > +command opcodes:
> > +
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd_list {
> > +       /* Indicates which of the below fields were returned
> > +       le64 device_admin_cmd_opcodes[];
> > +};
> > +\end{lstlisting}
> > +
> > +This structure is an array of 64 bit values in little-endian byte
> > +order, in which a bit is set if the specific command opcode
> > +is supported. Thus, \field{device_admin_cmd_opcodes[0]} refers to the
> > +first 64-bit value in this array corresponding to opcodes 0 to
> > +63, \field{device_admin_cmd_opcodes[1]} is the second 64-bit value
> > +corresponding to opcodes 64 to 127, etc.
> > +For example, the array of size 2 including
> > +the values 0x3 in \field{device_admin_cmd_opcodes[0]}
> > +and 0x1 in \field{device_admin_cmd_opcodes[1]} indicates that only
> > +opcodes 0, 1 and 64 are supported.
> > +The length of the array depends on the supported opcodes - it is
> > +large enough to include bits set for all supported opcodes,
> > +that is the length can be calculated by starting with the largest
> > +supported opcode adding one, dividing by 64 and rounding up.
> > +In other words, for
> > +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
> > +length of \field{command_specific_result} and
> > +\field{command_specific_data} respectively will be
> > +$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
> > +with round up and \field{max_cmd} is the largest available command opcode.
> > +
> > +The array is also allowed to be larger and to additionally
> > +include an arbitrary number of all-zero entries.
> > +
> > +Accordingly, bits 0 and 1 corresponding to opcode 0
> > +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> > +(VIRTIO_ADMIN_CMD_LIST_USE) are
> > +always set in \field{device_admin_cmd_opcodes[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
> > +
> > +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
> > +The \field{group_member_id} is unused. It is set to zero by driver.
> > +This command has no command specific data.
> > +The device, upon success, returns a result in
> > +\field{command_specific_result} in the format
> > +\field{struct virtio_admin_cmd_list} describing the
> > +list of group administration commands supported for the group type
> > +specified by \field{group_type}.
> > +
> > +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> > +is set to 0x1.
> > +The \field{group_member_id} is unused. It is set to zero by driver.
> > +The \field{command_specific_data} is in the format
> > +\field{struct virtio_admin_cmd_list} describing the
> > +list of group administration commands used by the driver
> > +with the group type specified by \field{group_type}.
> > +
> > +This command has no command specific result.
> > +
> > +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> > +query the list of commands valid for this group and before sending
> > +any commands for any member of a group.
> > +
> > +The driver then enables use of some of the opcodes by sending to
> > +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> > +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> > +both understood and used by the driver.
> > +
> We need to clarify that if LIST_USE command can be called only one time or
> multiple times.
> 
> For example first time for limited functionality, it enabled 10 commands
> specific to SR-IOV.
> Later when user wants to use SIOV, it enables additional SIOV specific
> command set.


clarified in a conformance statement


> > +If the device supports the command list used by the driver, the
> > +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> > +If the device does not support the command list
> > +(for example, if the driver is not capable to use
> > +some required commands), the device
> > +completes the command with status
> > +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> > +
> > +Note: drivers are assumed not to set bits in
> > +device_admin_cmd_opcodes
> > +if they are not familiar with how the command opcode
> > +is used, since devices could have dependencies between
> > +command opcodes.
> > +
> Can you please change to use the singular notion for device and driver in
> the note like rest of the above description?
> 
> > +It is assumed that all members in a group support and are used
> > +with the same list of commands. However, for owner devices
> > +supporting multiple group types, the list of supported commands
> > +might differ between different group types.
> > +
> >   \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >   An administration virtqueue of an owner device is used to submit
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

