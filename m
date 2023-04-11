Return-Path: <virtio-dev-return-12114-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF904C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:32:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4D7660348
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:32:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA9239863C9
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:32:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 96160986366; Tue, 11 Apr 2023 10:32:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84D0E98636D
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 10:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rnUm765OPf-LRNgCsl8OYQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T20RGg2h+OOsqYtX9Cq4Pm8YzKxp4RQLM2MW5syGVoM=;
        b=cN9AwKf97uETNcKSbCLbGN94J9TX5oSUwmCVL6j7qoYQvn9PxyZ4IWAtuEJ2bUZSWv
         qhWlitRccwikyuxNtjOmVxpcjpbrWMKsxFNvnQ2uTyBSRbsH//yQmwXjhiWcRjTSVdOD
         0dl3wv2DKdpb52Pfpz64DBDNOhRS2UHvR4SEXC2F+/cVON0eupSOWzVULq3iTfpP5wPo
         a8KUlVCVxlru6m5eI1WFU2tNcCW71HJmKjQo0+s5OcBSmA8tOYlAoxaXBiYuzh91LRj6
         ksjJI9Y5IFXB195Wso02HsSOq3tgwe9BwLQCrSu9Fs4ECrKyjFwfmmTVJuy5CrxwL4wa
         zqdA==
X-Gm-Message-State: AAQBX9eEAE1oOTeZ7ve00U8DCY5rZ4o2c7Qb+9bG9OIDl84IDa/DtGwM
	Piw5n3rE6JQfV8wLtcmjEMzAhg3iUQAlYkWakbNGEXICvwxsk1/tYM6i9gYwRgBAHDJ+ykAErZ1
	4xMvqfyhasTPNbJdLa2m/N60AX4ki
X-Received: by 2002:a7b:c013:0:b0:3f0:46d4:b391 with SMTP id c19-20020a7bc013000000b003f046d4b391mr9879796wmb.6.1681209175034;
        Tue, 11 Apr 2023 03:32:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350aygJ38p4mTroJxgdPm7nfn1MxPhl4UypuRPkBfqdVBnMrNzjv8GWOeizoO2QaHBjWNJlAB0g==
X-Received: by 2002:a7b:c013:0:b0:3f0:46d4:b391 with SMTP id c19-20020a7bc013000000b003f046d4b391mr9879776wmb.6.1681209174693;
        Tue, 11 Apr 2023 03:32:54 -0700 (PDT)
Date: Tue, 11 Apr 2023 06:32:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230411063059-mutt-send-email-mst@kernel.org>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <336f9b36-6704-51a6-0097-22381c623b8b@linux.alibaba.com>
 <87o7nukfns.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87o7nukfns.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Apr 11, 2023 at 10:05:11AM +0200, Cornelia Huck wrote:
> On Thu, Mar 23 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> 
> > Hi all! If after reviewing it you feel it meets the necessary 
> > requirements, I kindly request a vote.
> >
> > Thanks a lot!
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/166
> 
> So this has been voted upon and accepted, but we have further discussion
> downthread.
> 
> Should we merge the voted-upon version now and do further changes on
> top, or wait for the discussion to conclude first so that we can merge
> all of it in one go?

I think we should merge as is. vqn/idx/id are not new discussions
and have been going on before voting took place, so the TC
was informed. Parav is working on making tree-wide changes
around vq index applying this will not make his work
measureably harder.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

