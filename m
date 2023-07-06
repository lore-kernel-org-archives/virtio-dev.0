Return-Path: <virtio-dev-return-13250-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DB0EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 05:44:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B09C633581
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 05:44:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A525986729
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 05:44:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BE65986724; Thu,  6 Jul 2023 05:44:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71BF4986725
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 05:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ybAYDRX2NLq4Zspk0GTXNA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622241; x=1691214241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI/6XgKLDqbVRTaQdgV9q6dqAPw78BYRRls1muUb41U=;
        b=NGJPT9kk9I+6r0ZEmW7QtY++KlncyepW7HopnxSmWn5L3zB3JDKwgvpCOWDFGlNfJw
         3JQjzyPP3/rQa/3k6Id590c+CZ7B4l9F7YN5o98ziKanNC2phZv7q3jTmp9kECGwyDDa
         NYqphjWXpLgRsXEatzJg2NHE5YwJ8eWcUE/KoDrPSym3U+tUCaT2KhIM6L/WVkv8XBS4
         ZY0GBrDSQVf3dANaTMvyKPhePdqbYlozaZrbmhvN9R+fOpubMQaxiuZTgDw34J0V8dOW
         DwmVLq0733pU+fxpUopl8GLGmt3pHQMH//wkIP4moyYpcRYZaNEp8xiGpxTaOjz5SWkJ
         Zrvw==
X-Gm-Message-State: ABy/qLa3TtirwDBrdgUQLr35Jxamr9ZZF7vSYiAEdiuOYGdkYCa6P5nP
	W/ChgtzMKJm8tDXaEQFFMjoWeHA2d3JmkEDwNUw45sKwzN8ln7Lqfkrq6R8GTcobBnes1fF2Mgz
	6G11oGk1NNl5cCi+6BZV2eEDYkQBB
X-Received: by 2002:a05:600c:2901:b0:3fb:e189:3532 with SMTP id i1-20020a05600c290100b003fbe1893532mr447534wmd.20.1688622241255;
        Wed, 05 Jul 2023 22:44:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGd68FKSqcT4YAMPVNwWPvxmAlLQgRcHUwRGlaGg8S2ff1AmD1VRzdYtm675zVW9MUeNysWmg==
X-Received: by 2002:a05:600c:2901:b0:3fb:e189:3532 with SMTP id i1-20020a05600c290100b003fbe1893532mr447516wmd.20.1688622240983;
        Wed, 05 Jul 2023 22:44:00 -0700 (PDT)
Date: Thu, 6 Jul 2023 01:43:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230706013753-mutt-send-email-mst@kernel.org>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com>
 <87fs623bcg.fsf@redhat.com>
 <PH0PR12MB54816B8F00A8D403B9035B7BDC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816B8F00A8D403B9035B7BDC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v9 3/4] admin: Add group member legacy register access
 commands

On Wed, Jul 05, 2023 at 04:34:02PM +0000, Parav Pandit wrote:
> 
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Wednesday, July 5, 2023 6:24 AM
> > > +
> > > +In some systems, there is a need to support utilizing the legacy
> > > +driver with the device that do not directly support the legacy
> > > +interface. In such scenarios,
> > 
> > Maybe better:
> > 
> > "In some systems, there is a need to support utilizing legacy drivers with devices
> > that do not directly support the legacy interface."
> > 
> > ?
> >
> Can you please explain how plural is better if it is?
> I see this a lot intermixed in the spec.
> Why cannot we describe things using single object "the driver" and "the device"?
> I prefer to describe things without plurality as done in many parts of the spec.
> Please let me know.

It's ok too, but it must be consistent: "do" goes with plural. For
singular - "does".  Also this is the 1st time we mention this driver and
this device, so should be "a":

	In some systems, there is a need to support utilizing a legacy driver with
	a device that does not directly support the legacy interface.


> > > +a group owner device can provide the legacy interface functionality
> > > +for the group member devices. The driver of an owner device can then
> > > +access the legacy interface of a member device on behalf of the legacy
> > member device driver.
> > 
> > (...)
> > 
> > > +\paragraph{Legacy Driver Notification Query}\label{par:Basic
> > > +Facilities of a Virtio Device / Device groups / Group administration
> > > +commands / Legacy Interface / Legacy Driver Notifications Query}
> > > +
> > > +Even though the driver notifications can be communicated through the
> > > +administration command, if the group owner device or group member
> > > +device supports such notifications using a memory-mapped operation or
> > > +I/O operation, they are sent to the device by accessing such a
> > > +notification region using a memory or an I/O operation.
> > 
> > I find this sentence confusing, probably because it is too complex... what about
> > 
> > "If the group owner device or the group member device support driver
> > notifications via a memory-mapped operation or I/O operation, these
> > notifications are sent to the device via accessing such a notification region using
> > a memory or I/O operation {in addition to|instead of} communicating the
> > notifications through the admistration command."
> > 
> With instead of, it reads simpler. Will change it.
> 
> > (I'm not sure whether it is either or both.)
> > 
> > > +
> > > +A group owner device optionally support querying driver notifications
> > > +region
> > 
> > "can optionally support" ?
> >
> Ack.
>  
> > > +using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
> > > +
> > > +The driver sets command \field{opcode} to
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> > > +This command does not use \field{command_specific_data}.
> > > +
> > > +When command completes successfully, \field{command_specific_result}
> > 
> > "the command"
> > 
> Ack
> 
> > > +uses following structure:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

