Return-Path: <virtio-dev-return-13376-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF39C001DC
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:01:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E7EE13F8FE
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:01:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC4A49867C6
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:01:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CEF0C9867C1; Thu, 13 Jul 2023 11:01:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAC609867C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 11:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jHQAYApgMpiIG_hQeAECQQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246114; x=1691838114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/2rOdO9cTUlIlJb4UuutOjnx2Ih/MqS4USnMwRvZNg=;
        b=QtvFrJl3zZW7GyIWX+e9gwim6majns/A40i5Ns727o9gv1gSUOVh8JOE7Z7Fz3A+Pt
         SZtQclLSDT8gWXjSDKeyPm0jyptz8RaX6GpKLVZmKyG+AYqF9bJ5MM0VRXWRJBwjX0M/
         U71Rn0BO20/dqft2WrIA0UWeYoR5oNOJdXEyXJBFGx8M+JyQsIYuGyFDVLsTnZMXLDhi
         G17lYpOtVQfUYIt4UCeZGOOXzwjya6abk4wATxQmTxbwXi9C6iV/bG6gwRQhAMBU5Giy
         m+wf+8bEdF2A4+p54SBtlKGvgVd3WPgeoqogfqiAvDJnubDp+y3j3ts1JAbnRvhHOc1z
         T5zQ==
X-Gm-Message-State: ABy/qLYCswh0w3Nrgz/tSjLxWDZvMTZM04dGGMJbU01GfemZf07mgYxj
	+UfeX7Lgzcs2pwEFJ6j6s+3Jn5Z0gBODXhJ76+/tW3zO9PG9gIoFPSZ482k+N0TTluX4HZSEmM4
	EkyKlNqE+dKn7h1UiPLKqHzeQled2uesjRfMQ
X-Received: by 2002:adf:f84d:0:b0:315:ac1b:91e with SMTP id d13-20020adff84d000000b00315ac1b091emr1094463wrq.53.1689246114711;
        Thu, 13 Jul 2023 04:01:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkz1t4DikSuMFNBFgXuJ+iUTmPjNpy6iwhNoGSbstd0EJ10VAIzGHhEtmn4B5cqPpqLzChVQ==
X-Received: by 2002:adf:f84d:0:b0:315:ac1b:91e with SMTP id d13-20020adff84d000000b00315ac1b091emr1094452wrq.53.1689246114448;
        Thu, 13 Jul 2023 04:01:54 -0700 (PDT)
Date: Thu, 13 Jul 2023 07:01:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230713070130-mutt-send-email-mst@kernel.org>
References: <20230712222405.455201-1-parav@nvidia.com>
 <20230712222405.455201-4-parav@nvidia.com>
 <20230712184051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481634F6AA8E6553D5D0463DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87351ss050.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87351ss050.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 3/4] virtio-net: Use table to describe inner hash to rfc
 mapping

On Thu, Jul 13, 2023 at 10:09:47AM +0200, Cornelia Huck wrote:
> On Wed, Jul 12 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Wednesday, July 12, 2023 6:41 PM
> >> Hmm. escapechar did not work then?
> >
> >  Forgot to mention, I tried it, it didn't work.
> 
> It seemed to work for me (at least in the pdf) -- I'd prefer that one as
> a minimal change.

Yes it really should.  Could you post yours please?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

