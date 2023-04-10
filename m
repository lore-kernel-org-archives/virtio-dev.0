Return-Path: <virtio-dev-return-12101-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2A1C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:06:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44DE542A84
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:06:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 238CF9865B2
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 20:06:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 14C0298632A; Mon, 10 Apr 2023 20:06:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 790CE98661B
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 20:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ChhYSimoP0mpUXRXS-bZyA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681157080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOQOvWAYzDBEWMG9yOmrTmKKeDK5b0EZfZS3S3oQN30=;
        b=h0+Sx1aNh9mnTd5uQv+ybWsG7NQOh6JZYUUyGjkFxMiUcqE/7wq9Y3kO/Gr9MHZu71
         QnqfA4FA3dY4ZToABkxU8HRrgvffOvlfth5+eFlCbZXHdGK4s6icBLQZV5Zz6UDTmDSh
         iI1IKMWbMFE7AWCR1tkHh2YzpOVomct8LguKNE68RoY873qxJPCZ7GagDI855ICK/61q
         fKxT6aGPzmvyIFRNo8sbEhTGnoWZO+vvA27n5UB3PVjA9D82qsToR9rgstC+I484a2GR
         tHpBTIgNPmzr8PTmvAV6W5ODu1ftAxkQ/WJf807d2SxdoumkWIKFopTFG5mLcNLiGTo5
         iUnw==
X-Gm-Message-State: AAQBX9ej+6QMwjwTfFNMdLouVfkIaMK1B8Akok06ukq4XTO0P6EZ7quR
	0xIUScuzTyzYaIYCB2LbwEbA9bQWiEpSJ5TGuhv0gEUJ0lYZQXnrWaMy8deFm4hOJRBmUhzPUM5
	X4BeN6UwjMwMmgsYiB95/5ew9j630
X-Received: by 2002:a1c:4c12:0:b0:3eb:29fe:734a with SMTP id z18-20020a1c4c12000000b003eb29fe734amr376341wmf.39.1681157080399;
        Mon, 10 Apr 2023 13:04:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zvi7R7DacyzeAZ31XYNjkoT9L3ZYKjGr/1DDhaSUvMHrpOuZhjKQes2aB7h0RhyQZ4gq4/NA==
X-Received: by 2002:a1c:4c12:0:b0:3eb:29fe:734a with SMTP id z18-20020a1c4c12000000b003eb29fe734amr376325wmf.39.1681157080136;
        Mon, 10 Apr 2023 13:04:40 -0700 (PDT)
Date: Mon, 10 Apr 2023 16:04:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230410160357-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
 <20230410092104-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 04/10] admin: introduce virtio admin virtqueues

On Mon, Apr 10, 2023 at 02:22:20PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 10, 2023 9:23 AM
> 
> > Not sure why - these are synonims - and this variant is more popular:
> > 
> With my limited knowledge, when written for third person doing the adding entries to the queue, "enqueue" is suitable.

Look it up in a dictionary.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

