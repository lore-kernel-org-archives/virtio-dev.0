Return-Path: <virtio-dev-return-12383-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D0C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 20:32:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C33826A2F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 20:32:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BDCA98643D
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 20:32:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 512B7983F7A; Mon, 24 Apr 2023 20:32:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D6BE9863AC
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 20:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: x_WbcqYXOle3lR5XC-9aiA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368339; x=1684960339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfUS6H3ExTv8xc6Bt3zNJANeBJDhM4VUauPVxkt+5Os=;
        b=IJe8rbIKCGhKSKLPAW/6pNhDiPCydw59B2ME33doTvexeiHsSssxeMkGjmj0jDnWHQ
         FOyy8C3g6HhtOp4yPgxkRSYO9gcMpQJxOXa8fBYlCpIVsbIF5ShnrlwwA5DtVyue6sbl
         nmC+lgkMixEeecECJ6SonKvskC88Dkmw44d4NKKJTbEuTpzG442PKqOGKFCnTl0cjmqJ
         JwWu3TS/oZFSd/7Q4LLD+J5v4V/H7aPf3zhL+wRS+BbTHhEZ4o5f1uxmRGf+W8BzHZ6u
         om5oXRQEcNnDYJNjaLI7ihnZe0QlqTT4L5uLTyNgQChKjVCknyI0+AA2OnnQGAh8XwLd
         qrYg==
X-Gm-Message-State: AAQBX9dYgx3noNbrTyBx6X81yeEEc+w+d928myaUJzohyrlVEWtqW3nP
	8Q8MIQ4i+TTTYwJSJrE1fvERMtM1X+XHvdTPL19QMk/I4BzmBhMHsHp87EUDdszh637msiQem7k
	AmZJbEBk9vrOYQ5reYDjy80HtF2wX
X-Received: by 2002:adf:f30a:0:b0:2f5:9b1f:da81 with SMTP id i10-20020adff30a000000b002f59b1fda81mr9751517wro.54.1682368339679;
        Mon, 24 Apr 2023 13:32:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350apBns0xRqIE9Ayj2kxx8AZEfYUc6anLYYZmWnhzNXcBzHJuEaZDfXugtDH2DpDfLCPM0gMYA==
X-Received: by 2002:adf:f30a:0:b0:2f5:9b1f:da81 with SMTP id i10-20020adff30a000000b002f59b1fda81mr9751505wro.54.1682368339402;
        Mon, 24 Apr 2023 13:32:19 -0700 (PDT)
Date: Mon, 24 Apr 2023 16:32:14 -0400
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
Message-ID: <20230424131949-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
 <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
 <20230410092304-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548178169DF16AED534395EEDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230424122858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481083BCC4480E3303BA601DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481083BCC4480E3303BA601DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] RE: [PATCH v11 02/10] admin:
 introduce device group and related concepts

On Mon, Apr 24, 2023 at 04:45:27PM +0000, Parav Pandit wrote:
> 
> > From: virtio@lists.oasis-open.org <virtio@lists.oasis-open.org> On Behalf Of
> > Michael S. Tsirkin
> > 
> > On Mon, Apr 10, 2023 at 04:42:42PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, April 10, 2023 9:24 AM
> > >
> > > > > From this point onward you can add,
> > > > > --- line. So that it doesnt go to the commit log.
> > > >
> > > > I can but motivation for design choices is a good thing to have in
> > > > the commit log.
> > > >
> > > Yes.
> > > Righting it as
> > > Usually, I see those design notes or rationale written as third person
> > sentences.
> > >
> > > Also, since those design choices are good to capture, can we start cover letter
> > commit also, which usually give a complete or broad view of the design?
> > 
> > too much beaurocracy really imho.
> > 
> Commit log is capturing the use case and other design aspects of the spec.
> I don't see it as bureaucracy.

Motivation is what we have in the cover.  Considerations that went into
specific design are really hard to capture, and we have enough trouble
adding things to spec without adding extra requirements from
contributors to justify each decision.

> You didn't get the answer when _CONFIG_DATA question arises in past.
> You also didn't get answer from other Intel engineer, which was unreachable, I forgot the issue.
> Cover letter will capture those.
> 
> If we prefer to not have cover letter, please move these details in the individual patch.
> Anyways you send out v12 so next work.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

