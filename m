Return-Path: <virtio-dev-return-13251-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2735DEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 06:01:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7F75141EE5
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 06:01:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5354F986728
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 06:01:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35626986724; Thu,  6 Jul 2023 06:01:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 207D7986725
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 06:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nDsBBI6vPpqCchCyl0voig-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623288; x=1691215288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UL3VmcxWzrEF7+xAx60c7adwptmT9/yvpLWUbM7LGY=;
        b=X9842hVcJk2bTGYxk2DyZYjKolYaNTIrZhUq0939AfZhvhgocMIBNMvv0yF0Nz7tRa
         Hs4P1Nazc6vETQOAJJdPHO0W1dSqZHejPYyjcgGi7sCN+L3Pz+3jGuopQnFq4kj0Z0Kx
         JNtYRCmEOeIpGJrkdsci1a9mocT/td13ha7snmLdhE/QlbB3KPI6RhvyBLa8O+CmTgic
         GGxMuzh4N8MZbqNkjoooJn8hcW3c4Z+iAiNG6TeWV29z+uEYcQBGr0Flfzle5XR7t0VF
         10WSKeZOUUNkXkmjRzgC3zYP2FRd9O7xmOE49okEYbx2QtuDjFeIel6Yi7IT7kOvfGLA
         C0Dg==
X-Gm-Message-State: ABy/qLbJtBTFcxDrNfnLc9AIGMv8x6eJI8BhqMLuTZOTDD3al21oYRaB
	mE/4O5m5syQh3QTDh3jw3Bh4Hvz2FKzPmx1Pu2uyJ5xRgkhtMaz8mH696g+gVXKHJfIkhh9QyXe
	7nn8o21Wh1qziZgfyBgmoLLJtgWvH
X-Received: by 2002:a05:600c:210c:b0:3fb:403d:90c5 with SMTP id u12-20020a05600c210c00b003fb403d90c5mr441448wml.39.1688623287649;
        Wed, 05 Jul 2023 23:01:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHk/1EJ72uH98K23SwXiXMvTLcBgVj/eSGmLh9Y1dRIBeXXtVSuJ4y/pcYFdbIVtcu+Y2ifZg==
X-Received: by 2002:a05:600c:210c:b0:3fb:403d:90c5 with SMTP id u12-20020a05600c210c00b003fb403d90c5mr441425wml.39.1688623287219;
        Wed, 05 Jul 2023 23:01:27 -0700 (PDT)
Date: Thu, 6 Jul 2023 02:01:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230706014514-mutt-send-email-mst@kernel.org>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com>
 <20230705044626-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811DF4C327E27346DCF950DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811DF4C327E27346DCF950DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v9 3/4] admin: Add group member legacy
 register access commands

On Wed, Jul 05, 2023 at 06:26:13PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, July 5, 2023 7:05 AM
> 
> 
> > > +These commands are currently only defined for the PCI SR-IOV group
> > > +type and
> > 
> > We call it SR-IOV group type not PCI SR-IOV group type. Please be consistent.
> >
> Ack.
>  
> > > +have, generally, the same effect as member device accesses through a
> > > +legacy interface listed in section \ref{sec:Virtio Transport Options / Virtio
> > Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device
> > Layout}.
> > > +
> > > +\paragraph{Legacy Common Configuration Write Command}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Common Configuration Write Command}
> > 
> > Fix label.
> > 
> It is already under the tree of Legacy interface so dropped making it further longer.
> But than I kept the Legacy in the actual name...
> Will add Legacy in the label.
> 
> > > +
> > > +This command has the same effect as writing into the virtio common
> > > +configuration structure through the legacy interface.
> > > +\field{command_specific_data} has the following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_common_cfg_wr_data {
> > > +        u8 offset; /* Starting byte offset within the common configuration
> > structure to write */
> > > +        u8 reserved[7];
> > > +        u8 region_data[];
> > 
> > I am all for something more specific than offset/data but region seems pointless.
> > And why apply just to data not offset?
> > How about legacy_offset/legacy_data?
> >
> Structure name already has legacy, so no point in repeating legacy_ prefix again in all the fields inside.
> I will drop region_ and just keep offset,data.
>  
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
> > > +The driver sets valid \field{offset} and associated
> > > +\field{region_data} bytes to write to the common configuration region.
> > > +
> > > +This command does not use \field{command_specific_result}.
> > > +
> > 
> > Let's make this consistent with other commands, even if it means we repeat
> > ourselves a bit. And length is not documented and has to be:
> > 
> Ah yes, I missed the length documentation.
> Will add it.
> 
> Not sure what part you want to make consistent with other commands?
> Do you mean to repeat ourselves for the opcode number? If so, than we should be avoiding it.
> In fact we should remove that repetition in other commands too. We have table to describe it clearly.

Then "set opcode to XXX" would be redundant too.

> > 
> > >>>
> > 
> > For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > \field{opcode} is set to 0x2.
> > The \field{group_member_id} refers to the member device to be accessed.
> Yeah, there is certainly  no point in repeating all of these again.
> 
> In previous patch when I repeated where it says it uses the struct virtio_admin_cmd, you asked to drop for the right reason.
> But here you ask to repeat other things...
> Not good.
> 
> All above is crystal clear in opcode table and in generic description already.
> Reader has less text to read to understand it.

I actually think it's helpful - whoever is writing a driver
then has a single place to read.
it does not matter if we repeat ourselves a bit - readers are
not compilers.


> > The \field{command_specific_data} is in the format \field{struct
> > virtio_admin_cmd_legacy_common_cfg_wr_data} describing the access to be
> > performed.
> > 
> > Within \field{struct virtio_admin_cmd_legacy_common_cfg_wr_data}:
> > The \field{offset} refers to the offset to write within the virtio common
> > configuration structure, and excluding the device-specific configuration. 
> "virtio common configuration structure" is self-explanatory that doesnt need to add the exclusion part.
> Hence it was not added in v9 too.

Again readers are not compilers. It's not 100% clear whether it's legal
to access device specific through this or not.


> > For the
> > SR-IOV group type, the layout used refers to the one used for the legacy
> > interface as listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI
> > Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout},
> > except that little endian format is assumed unconditionally.
> > The length of the data to write is simply the length of \field{region_data}.
> > 
> > No length or alignment restrictions are placed on the value of the \field{offset}
> > and the length of the \field{region_data}, except that the resulting access refers
> > to a single field and is completely within the virtio common configuration
> > structure, excluding the device-specific configuration.
> > 
> > This command has no command specific result.
> > 
> > 
> > Try to apply this to other commands please.
> >
> I will apply rest of the above text you wrote for this and rest of the commands.
>  
> > > +\paragraph{Legacy Common Configuration Read Command}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Common Configuration Read Command}
> > > +
> > > +This command has the same effect as reading from the virtio common
> > > +configuration structure through the legacy interface.
> > > +\field{command_specific_data} has the following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_common_cfg_rd_data {
> > > +	u8 offset; /* Starting byte offset within the common configuration
> > > +structure to read */ }; \end{lstlisting}
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
> > > +
> > > +The driver sets valid \field{offset} of the region from where to read
> > > +\field{region_data}.
> > > +
> > > +When command completes successfully, \field{command_specific_result}
> > > +uses following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_common_cfg_rd_result {
> > > +        u8 region_data[];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\paragraph{Legacy Device Configuration Write Command}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Device Configuration Write Command}
> > > +
> > > +This command has the same effect as writing into the virtio device
> > > +configuration structure through the legacy interface.
> > > +\field{command_specific_data} has the following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_dev_reg_wr_data {
> > > +        u8 offset; /* Starting byte offset within the device configuration
> > structure to write */
> > > +        u8 reserved[7];
> > > +        u8 region_data[];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
> > > +The driver sets valid \field{offset} and associated
> > > +\field{region_data} bytes to the device configuration region.
> > > +
> > > +This command does not use \field{command_specific_result}.
> > > +
> > > +\paragraph{Legacy Device Configuration Write Command}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Device Configuration Read Command}
> > > +
> > > +This command has the same effect as reading from the virtio device
> > > +configuration structure through the legacy interface.
> > > +\field{command_specific_data} has the following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
> > > +        u8 offset; /* Starting byte offset within the device
> > > +configuration structure to read */ }; \end{lstlisting}
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
> > > +The driver sets valid \field{offset} within the device configuration
> > > +structure from where to read \field{region_data}.
> > > +
> > > +When command completes successfully, \field{command_specific_result}
> > > +uses following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_dev_reg_rd_result {
> > > +        u8 region_data[];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\paragraph{Legacy Driver Notification Query}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Legacy Driver Notifications Query}
> > 
> > Drop "Query", this talks about notifications generally.
> >
> Ok.
>  
> > > +
> > > +Even though the driver notifications can be communicated through the
> > > +administration command, if the group owner device or group member
> > > +device supports such notifications using a memory-mapped operation or
> > > +I/O operation, they are sent to the device by accessing such a
> > > +notification region using a memory or an I/O operation.
> > 
> > > +
> > > +A group owner device optionally support querying driver notifications
> > > +region using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
> > 
> > The driver of the owner device can send a driver notification to the member
> > device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > with the \field{offset} matching \fielf{Queue Notify} and the \field{region_data}
> > containing the virtqueue index to be notified.
> > 
> > However, as many administration commands are used for slow path
> > configuration, a separate fast path mechanism for such notifications is desired.
> > For the SR-IOV group type, the optional command
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY addresses this need by
> > returning to the driver one or more addresses which to be used to send such
> > driver notifications.
> > 
> Ok. will take this version.
> 
> > 
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> > > +This command does not use \field{command_specific_data}.
> > > +
> > > +When command completes successfully, \field{command_specific_result}
> > > +uses following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_notify_query_entry {
> > > +        u8 region_data[16];
> > 
> > So everything is pci specific but this one we for some reason decided to keep
> > generic. I'd just make it pci specific, keep things simple.
> > We'll generalize if and when other transports want this. Which I doubt.
> >
> Other is kept generic.
> The whole thing was documented as PCI first and ask was to make it generic for the description.
> And now again you suggest making it pci specific.
> What changed from PCI->GEN->PCI?
> Why the whole text should reside in generic file if you want to make it PCI specific, like before?


I always said notification is the most problematic part of it.
Rest we made generic and it looks good to me.

At this point this notification part is still stated confusingly and I
think we should give up on making notification generic for now for
purpose of expediting merging this.  Deleting a bunch of text is
easier than trying to restate it clearly.



>  
> > 
> > > +};
> > > +
> > > +struct virtio_admin_cmd_legacy_notify_query_result {
> > > +	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
> > > +}; \end{lstlisting}
> > 
> > here I'm not going to repeat myself. same comments as other commands.
> > 
> > > +
> > > +The driver picks the suitable entry when multiple entries are
> > > +supplied by the device.
> > 
> > How does driver know how much to allocate?
> > I think it allocates an extra entry, inits it to 0, then after the command checks
> > whether it was modified. If yes makes the buffer larger. Makes sense? Complex
> > though ...
> > Can we place an upper limit on # of entries? 4 seems sufficient no?
> > And what is "suitable"? I am guessing it just picks the
> > *first* entry that it is able to utilize.
> > And devices list them in the order of preference.
> >
> Driver can just allocate some random for 1, 8, 16 entries based on how it wants to do.

What if e.g. it wants to access through member, allocates just 1
entry and device fills that with owner instead?

I don't think it works.

> Suitable is whatever driver can decide, first or last or prefer PF over VF, driver's choice....
>  
> I don’t know why to complicate this a lot when most devices that I know of will do 1 entry.
> May be 2nd for the PF.
> And may be device can overdo it by adding one more for some large IOBAR in theory on the PF.
> 
> 4 seems some arbitrary number.

So you got to 3 above, 4 just adds a spare one, and it's a power of two :)

I agree we do not need to complicate it but driver does not know
how many entries to scan. How about simply:

	struct virtio_admin_cmd_legacy_notify_query_result {
		struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[4];
	};

and explain that device zero-initializes unused entries.
we then replace "owner" with "flags" and make the low flag "valid".



> > > +
> > > +Refer to the specific transport section for the definition of the
> > > +\field{region_data}.
> > 
> > Transport sections are huge. Links please do not make the reader guess.
> > 
> > > +
> > > +This command is currently only defined for the PCI SR-IOV group type.
> > > +\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a
> > > +Virtio Device / Device groups / Group administration commands /
> > > +Legacy Interface}
> > > +
> > > +If the group owner device supports legacy region access for its group
> > > +member devices, the device MUST set all corresponding bits for
> > > +commands VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ in the command result
> > > of VIRTIO_ADMIN_CMD_LIST_QUERY in
> > > +\field{device_admin_cmd_opcodes}.
> > 
> > 
> > It's enough to just say what is supported:
> > 
> > A device MUST either support all of, or none of
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ.
> >
> Ok.
> > > +
> > > +The device MUST encode and decode legacy device specific registers using
> > > +little-endian format.
> > 
> > For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > the device MUST decode and encode (respectively) the value of
> > the \field{region_data} using the little-endian format.
> >
> Ack.
>  
> > 
> > 
> > > +
> > > +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > and
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands for the
> > invalid offset
> > > +which is outside the legacy common configuration region's address range.
> > 
> > The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > and
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands where the
> > value of the
> > \field{offset} and the length of the \field{region_data} does not refer
> > to a single field or is not completely within the virtio common
> > configuration structure, excluding the device-specific configuration.
> > 
> This is an additional limitation being added, but fine, it doesnt hurt anyone.

Not really - your text said "offset has to be valid" but never explained
what is valid. Not how conformance statements should look.
I tried to include a definition above.


> > 
> > > +The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands for the invalid
> > offset
> > > +which is outside the legacy device specific region's address range.
> > 
> > The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ and
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands where the value of
> > the
> > \field{offset} and the length of the \field{region_data} does not refer
> > to a single field or is not completely within the device-specific
> > configuration.
> >
> Same as above.
>  
> > 
> > 
> > > +
> > > +The device SHOULD support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> > command for
> > > +driver notifications. If the group owner device supports driver
> > > +notifications region for its group member devices, the device MUST set
> > > +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY in the command result of
> > > +VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.
> > 
> > I don't get what does all this mean. Seems to say if you support
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY then set it. Reader should know
> > that anyway.
> > 
> > Should we say:
> > 
> > If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY it MUST
> > also support all of
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ.
> > 
> Yes, you captured it better. Thanks.
> 
> > 
> > > +
> > > +When the driver accesses the legacy region of the member device using
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ
> > > +commands, device MUST function as if they are accessed by the legacy
> > interface
> > > +defined by the transport of the member device.
> > 
> > The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST
> > have the same effect as writing into the virtio common configuration
> > structure through the legacy interface.
> >
> ok
>  
> > repeat for the other commands.
> > 
> o.k.
> > 
> > Also, explain about notification: is it true that writing
> > at this address has the same effect as writing into Queue Notify?
> > 
> Yes, will add.
> 
> > 
> > > +
> > > +\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio
> > Device / Device groups / Group administration commands / Legacy Interface}
> > > +
> > > +The driver MUST encode and decode legacy device specific registers using
> > > +little-endian format.
> > > +
> > > +The driver SHOULD send
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
> > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands with a
> > valid offset which
> > > +is in the legacy common configuration region address range.
> > > +
> > > +The driver SHOULD send commands
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ with a valid offset which is in
> > the legacy
> > > +device specific configuration region address range.
> > > +
> > > +The group member driver SHOULD use the notification region supplied by
> > the group
> > > +owner device.
> > 
> > Use how? More specific please. Also, only if the command is supported.
> > 
> >
> How to use is already part of the existing spec.

No - because what is in the spec is how the legacy driver uses it.
But legacy driver also uses IO accesses for configuration
and we replace these with commands. This is a pass-through
trick. Need to document this.



> I will add a line to refer to the driver notification spec section.
> 
> Ack will add about 'if command supported'.
> 
>  
> > Document how is notification thingy used.
> >
> > 
> > 
> > > diff --git a/admin.tex b/admin.tex
> > > index fd3b97d..0de26a9 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -117,7 +117,17 @@ \subsection{Group administration
> > commands}\label{sec:Basic Facilities of a Virti
> > >  \hline
> > >  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of
> > commands used for this group type \\
> > >  \hline
> > > -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> > > +0x0002 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE & Write
> > legacy common configuration region of a member device \\
> > > +\hline
> > > +0x0003 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ & Read
> > legacy common configuration region of a member device \\
> > > +\hline
> > > +0x0004 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE & Write legacy
> > device configuration region of a member device \\
> > > +\hline
> > > +0x0005 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Read legacy
> > device configuration region of a member device \\
> > > +\hline
> > > +0x0006 & VIRTIO_ADMIN_CMD_LEGACY_DEV_NOTIFY_QUERY & Query
> > notification region for a member device \\
> > > +\hline
> > > +0x0007 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> > >  \hline
> > >  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a
> > different structure)    \\
> > >  \hline
> > 
> > 
> > Grammar fix + drop "region":
> >
>  
> >  VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Writes into the legacy
> > common configuration structure
> >
> Ack.
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

