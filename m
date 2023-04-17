Return-Path: <virtio-dev-return-12249-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B73C77B77
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 11:45:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3B27B77F6
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 11:45:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 100739863E8
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 11:45:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E36DC98632B; Mon, 17 Apr 2023 11:45:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D04CB986353
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 11:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: J1VuG0uDOZ2sB9wj90OpnQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731932; x=1684323932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKAIGvBiSXmh+OkPnmG10wmCrFGUTrMjUFgFyMV9Z1c=;
        b=U24qeYaz5obAPUt3JoAf22m0eJ0RsdWcfssU0R4+lxACmUrHVJy7j+3kWJDZAehaNd
         YF0W/EUQCc+cQUstFueIR1yAJaPOajhn9msCq5YiAcwW9ouo5+AWT/AXqyzh6NfQBJQP
         KbgA1hqxq5fjDjRKAmzYOnhEMP5oRxKPY9zLdIl9mcxKPLvdzcTqbkwJ1dwr8rKof+9p
         gHDAr9qa34Jf1kzCgInZBTk0309FQxDa7xxyZCpF87EKH59TCj+IYgNiJiBYocpV29BQ
         YohGVNT+jbpkeN53e1lhLNq6yZgqD7WTTBIm/BtwwUiQU5H2kiU6GsjWqzC2j3kwptYk
         5+qQ==
X-Gm-Message-State: AAQBX9d0mlsbJfjaXnbuFrU+VeyOE37W28FxO2lb4OfmJZN1WlNHxgG0
	HI+u/Huqnsf3LRXLz3kc4447/3ZejK3td9mVxFvZcIL2b5YCvkmstVt4wKatMMeQZBYCb9q2fjs
	L0GgBmZ4t5LxbkdLmEopRgG7NftK3
X-Received: by 2002:a7b:c44a:0:b0:3eb:42fc:fb30 with SMTP id l10-20020a7bc44a000000b003eb42fcfb30mr11025596wmi.32.1681731932594;
        Mon, 17 Apr 2023 04:45:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZaN/r2Wf0WKStli61UsZVWx4NrmfOV5+jrw7Oss/nJhZNr+a22eiohhGriFpQTIag4VkahRA==
X-Received: by 2002:a7b:c44a:0:b0:3eb:42fc:fb30 with SMTP id l10-20020a7bc44a000000b003eb42fcfb30mr11025582wmi.32.1681731932338;
        Mon, 17 Apr 2023 04:45:32 -0700 (PDT)
Date: Mon, 17 Apr 2023 07:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230417074243-mutt-send-email-mst@kernel.org>
References: <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407073308-mutt-send-email-mst@kernel.org>
 <87ile2kdav.fsf@redhat.com>
 <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417051844.70ba47cc.pasic@linux.ibm.com>
 <20230417024402-mutt-send-email-mst@kernel.org>
 <878reqlwss.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <878reqlwss.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: Participation (was: Re: [virtio-comment] RE: [virtio-dev] RE:
 [PATCH v12 03/10] content: Rename confusing queue_notify_data and vqn names)

On Mon, Apr 17, 2023 at 10:47:47AM +0200, Cornelia Huck wrote:
> I agree that patch reposting is happening much too fast in some
> cases. Not sure how to formalize that, either. Can we please just be
> more mindful of that? Reviewing time is not free. If I'm trying to do a
> timely review of something and constantly see new versions while I'm not
> finished yet, I do not feel like my feedback is actually valued.

Imagine a group of contributors working on spec 100% of time.
What do you want them to do? they need to exchange patches,
slowing them down because part time reviewers are overwhelmed
would be a waste. A separate mailing list would be one
solution. Some tag in the subject would be another. RFC?
Though RFC is used for other things as well...

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

