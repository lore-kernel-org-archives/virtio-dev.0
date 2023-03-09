Return-Path: <virtio-dev-return-11571-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3DAC64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:55:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 908562AC51
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:55:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89DD0986702
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:55:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7F0929866F6; Thu,  9 Mar 2023 13:55:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68FE69866FC
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 13:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kWK7xp6MNvWgN0jh6PIWKA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypWQ3MqWDxaGQlJbf1BaO9jqW6vlCO7UiRw+dgYV524=;
        b=i/MErzh/3Gw8GxgwbXzcFSBnHy6N+lHQryCSX7vXn0vFM4bwHOUHxGNkFEgcIuzGUh
         XWQQbOe3x9qSNOYysTKf9uA112HRCGk+Egu+4Dy9hAnXO8utzZOQy5UBqQMNCShWQwRI
         X7EbfRK8E4vIzkxdrA+rPxOZCx0AXNMXd/6cZsoNNujHsqSKyp0XIQ0PlYGSK0jmsSqM
         q58xP+KoceIKrbVeJavn2CN25hcabyZeiqpkrnCj91KqcJYZ4KMvoG1tre49p9DkCaTQ
         3V9zif30pWsCaDMpy7kqDBMBcnEAS2KO5HOAdyb0FHE3ysocnXkUehw8IH7yEVcaKVXJ
         g8kQ==
X-Gm-Message-State: AO0yUKVz7OtUiz4EDsU82lkoM1BESidsTvNH9dJoBiDhSNIXBtLSxiW8
	TgLyqeZItnuoKFwgWRPWaXlYGDMmeR2Cv77Uc9zUbuFcgCXYBXjDzDJCKs0qRDXXRIGncjW+eI8
	gZEjnYRfHh0iYgV/U/mnCKjx4lWWV
X-Received: by 2002:a17:907:a094:b0:8aa:c143:ffe1 with SMTP id hu20-20020a170907a09400b008aac143ffe1mr22985584ejc.48.1678370121610;
        Thu, 09 Mar 2023 05:55:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/uRSmgg4uTO7E+ffkuc6kjQ0pieg3LE/QGTM1EXcmtJeEsjrPyoveQbgsQF9aUeVR2xLBZfA==
X-Received: by 2002:a17:907:a094:b0:8aa:c143:ffe1 with SMTP id hu20-20020a170907a09400b008aac143ffe1mr22985516ejc.48.1678370120394;
        Thu, 09 Mar 2023 05:55:20 -0800 (PST)
Date: Thu, 9 Mar 2023 08:55:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	sgarzare@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230309085432-mutt-send-email-mst@kernel.org>
References: <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
 <20230308141317.GC299426@fedora>
 <18ddbf69-19a6-3c6b-9e42-aaae66e20bcf@nvidia.com>
 <20230308171523.GA320810@fedora>
 <20230308122017-mutt-send-email-mst@kernel.org>
 <20230309123542.GC370169@fedora>
MIME-Version: 1.0
In-Reply-To: <20230309123542.GC370169@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

On Thu, Mar 09, 2023 at 07:35:42AM -0500, Stefan Hajnoczi wrote:
> On Wed, Mar 08, 2023 at 12:21:46PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 08, 2023 at 12:15:23PM -0500, Stefan Hajnoczi wrote:
> > > > > > > Or we could say that admin commands must complete within bounded time,
> > > > > > > but I'm not sure that is implementable for some device types like
> > > > > > > virtio-blk, virtio-scsi, and virtiofs.
> > > > > > 
> > > > > > No we can't.
> > > > > > Some commands, for example FW upgrade can take 10 minutes and it's perfectly
> > > > > > fine. Other commands like setting feature bit will take 1 millisec.
> > > > > > Each device implements commands in a different internal logic so we can't
> > > > > > expect to complete after X time.
> > > > > 
> > > > > When I say bounded time, I mean that it finishes in a finite amount of
> > > > > time. I'm not saying there is a specific time X that all device
> > > > > implementations must satisfy. Unbounded means it might never finish.
> > > > 
> > > > There might be a chance that any command for any virtio device type will
> > > > never finish. Nothing new here in the adminq.
> > > > 
> > > > what one can do is to set a timeout for himself and if this timeout expire -
> > > > check the device status. If it needs_reset - do a reset. if status is ok,
> > > > then wait some more time.
> > > > After X retries, unmap buffers or reset the adminq.
> > > 
> > > Michael: What effect does resetting the group owner device have on group
> > > member devices?
> > 
> > virtio level reset? It's a good question. I'd expect them all to be
> > reset no?
> > 
> > > I'm concerned that this approach disrupts all group member devices. For
> > > example, you try to add a new device but the command hangs. In order to
> > > recover you now have to reset the group owner device and this breaks all
> > > the group member devices.
> > 
> > 
> > I agree. How about a VQ level reset though? Seems like exactly
> > what's needed here?
> 
> Yes, a new virtqueue-level reset feature would take care of this case.
> 
> Stefan

Why would we need a new one? We already have VIRTIO_F_RING_RESET.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

