Return-Path: <virtio-dev-return-12368-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B03C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:30:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E65A29FE5
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:30:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38D0F98642D
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:30:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2CF79986385; Mon, 24 Apr 2023 16:30:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CF63986367
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TcgTq8cRNv6uaP-vhmYVOQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353831; x=1684945831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK4kq/ILZQw9nUucyG7B+O2UQyQ12SxHp8soyLFrBk0=;
        b=kGtzRC/wj2HAp9S2mEoJY9V5ZQn3SHV6g5GmRfbdEKvnvfb2A4uecON7l44l+MYv/l
         iy9Y/4POquHOowQXpbrZ+PivHfMuWSoTn3ci22J4iIoXqE0BmJqqZdUrGiKIAABNABHk
         zgyk5RxsEDQfMxV9u8UD5mwCjyqvab7Dl/LJQBCbQNDowXh8dZ0zinJiIxIi2QWr/ox7
         E9OaYK/LF7nalscghejVBcrjfdKVtYr6afWfkbipO3tz+6xxlDRn1b7azQ49W1hGR7AK
         owXkSiLi03gkIWZQwWSvlYA6H31oIuYTCJOzahdbTOSaPrA7WMue8uEnMbsQONg6jMOj
         LWKw==
X-Gm-Message-State: AAQBX9eDVubx6AwsVik7+TX5cRQrwhGdbjrjEpyfjXFvtnXDohvAqRUt
	+fAMM+KOxqLl1oGWZkm1kpSl+Y6h3ecE2jX9m4ravITT83KcgOe4LlyAHksa77+S/RQ9tzoT6tB
	d7hy6EZgEBitHu7Cd4pZDTH55S5tE
X-Received: by 2002:a1c:770d:0:b0:3f0:8fb3:24ea with SMTP id t13-20020a1c770d000000b003f08fb324eamr8195380wmi.9.1682353830782;
        Mon, 24 Apr 2023 09:30:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350YBApl0QSY0e6tN2tWJ2q4lsnY6qRO82K2aS3+2Ovx1TGlns1nti/aJXT21aC4WNDZdl19nTA==
X-Received: by 2002:a1c:770d:0:b0:3f0:8fb3:24ea with SMTP id t13-20020a1c770d000000b003f08fb324eamr8195367wmi.9.1682353830458;
        Mon, 24 Apr 2023 09:30:30 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:30:25 -0400
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
Message-ID: <20230424122858-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
 <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
 <20230410092304-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548178169DF16AED534395EEDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548178169DF16AED534395EEDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v11 02/10] admin: introduce device
 group and related concepts

On Mon, Apr 10, 2023 at 04:42:42PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 10, 2023 9:24 AM
> 
> > > From this point onward you can add,
> > > --- line. So that it doesnt go to the commit log.
> > 
> > I can but motivation for design choices is a good thing to have in the commit
> > log.
> > 
> Yes. 
> Righting it as
> Usually, I see those design notes or rationale written as third person sentences.
> 
> Also, since those design choices are good to capture, can we start cover letter commit also, which usually give a complete or broad view of the design?

too much beaurocracy really imho.


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

