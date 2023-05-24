Return-Path: <virtio-dev-return-12819-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968FC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:15:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 597B2F3F57
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:15:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25D8598655E
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:15:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BA04983E27; Wed, 24 May 2023 20:15:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDEFC9864F6
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 20:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kpRYgtlpPyqE-G508bs-9Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959349; x=1687551349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIaz3FfBy7dMnbHkBitAcK97lY8cnJMtjtZeJ1q86EU=;
        b=Zfe/vsiCXm2/lHlwN2R58CcsXpZIr1HJ/YVE2ZH8Dd1/FGhMg6CeFBN5nj2qdSJcEf
         rjSvXgglhN8J4kp25mlNcX6FhXlKN5a17qA1ks7h7ymhRx7C3KQxLVr2y5lfeOHJ8r6r
         o8TVVNYBKmZuhryEFwsGzlIEofwimW+2TX0iEcfyPZSM+XCqKBaa7EWO25KMbZy3anRy
         3T4cDv7iAHzT+XsERmLG6BWuKlhySNmIwqX16kqSdiVB7C9pDkjxdMpxPo+IklHWLhvL
         Z9x+0b0x268FzyzgywZJLDLJs/8KkNIVFPl81MZ/BMiv3ZGwLeAu5lj1snI8/uNw/qvH
         J/Nw==
X-Gm-Message-State: AC+VfDzJP+jlOf+diyCxiN9MzSfAixy9jZWqmDJZ0wzUiVCMvoMyA6um
	iZte7lrwHSkksBiq2uPKp2qP2Ew9stMuJ9/dk5JniyM/1zS4GY7+jJgwn4cFiik2YffL1tTO9Py
	1NLxGgOeHTHd0n4OWm1KHdAk3uGYj
X-Received: by 2002:a5d:58d5:0:b0:309:3698:7feb with SMTP id o21-20020a5d58d5000000b0030936987febmr566156wrf.46.1684959349167;
        Wed, 24 May 2023 13:15:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4WLK0GAHIgUjgLjbrL/AKaBrqHfBf0vOrinao6Pw5zMRb5GsHGAmgr0XwY6GKuF9YJne3JOQ==
X-Received: by 2002:a5d:58d5:0:b0:309:3698:7feb with SMTP id o21-20020a5d58d5000000b0030936987febmr566136wrf.46.1684959348859;
        Wed, 24 May 2023 13:15:48 -0700 (PDT)
Date: Wed, 24 May 2023 16:15:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230524161305-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141439-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E89D0E5DD6F291F8E149DC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524013429-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E07A038AFF7E461C6912DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524155301-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814EE70FDB58A2CABFB313DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814EE70FDB58A2CABFB313DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 24, 2023 at 08:01:18PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 24, 2023 3:58 PM
> 
> > > > Hope this helps.
> > > Definitely a good suggestion.
> > > I will send PR for virtio-docs to maintain our TODO list.
> > 
> > Hmm. This is just a dumping ground then.  Fine by me, but what I had in mind is
> > a common list of known problems to address by TC as a whole.
> > If you want that we want patches on list and discussion, maybe even voting.
> > 
> It is not a dumping ground, it is the list of things to track and document without searching emails.

virtio-doc is a dumping ground though :)

> It is a patch on the list for the doc in virtio-docs area that if needed can be voted.

Let's start with nvidia-todo.md in virtio-doc indeed. People can at
least read it, good starting point. Next I would like us to proceed to
a todo list under virtio-spec, so that TC at least knows what are
current problems before us.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

