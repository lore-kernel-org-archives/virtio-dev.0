Return-Path: <virtio-dev-return-13810-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55174CD3437
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:27:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9599668469
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:27:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 843F6986555
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:27:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7633E98637D; Tue, 19 Sep 2023 04:27:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68B729864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 04:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: e71N4fgmO1-DwiVKAtRSZg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097667; x=1695702467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HikF7S4zjKGZKcQ7S+IQ0RCJq/hsgPJIyrHxEttonEc=;
        b=HQezSvLVXoj9vMuQeggf17QpLKVyNVOti0S0Zz4CCX37ih8jsvik57M9rEzVY6Pvk6
         8lMpbxxhbqpkYI+JOWwZTpf/h0+rmryDXkMgJdVWXKOm+kxy8HGLZsib7E3VyrVI8EWx
         mWs5g4p6b5/Q70sFY8FZhN5pm4O6cTxgpx8GiHAQEt8W3TBHU7SapuehH5+5QMA3QNC0
         6G58iYNt1fak9wgGxyMCMErm5/AMPrE8K5hu8DiiIY1yakfaumMkAgNPNAq4gg9OmkWh
         DZuzIv43kD04IppR08xg+D6tY7HvC57HJ4SthIR3RkhYAe4Bb3hXT4pO1xQsjN05Brou
         0Jkg==
X-Gm-Message-State: AOJu0YwEDTh0TNCwDW/wdCUEaw7pptle4LYBLOFwKvuzlUJxWDRuYx0C
	cRsJGfJOA74BUMdmG6mYcm9OJPd0l4LNsvCHw7/2bd1ixS8xJy9r8R8ydNlz3AItnaJi2GFgWxY
	T/qIX/Lpd63sKF1fMqVirNLTJOgfAaqvkq26neSkcsYKw
X-Received: by 2002:a19:ca13:0:b0:503:afa:e79 with SMTP id a19-20020a19ca13000000b005030afa0e79mr4013291lfg.5.1695097667607;
        Mon, 18 Sep 2023 21:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/pchhpifmUa2eNKnAdj9t0Kb371cB83Bslc4AQnnM2UE8VLQpLEPwb47Y6tUF+TXzDtu+qGCydEWuFrRM2lk=
X-Received: by 2002:a19:ca13:0:b0:503:afa:e79 with SMTP id a19-20020a19ca13000000b005030afa0e79mr4013280lfg.5.1695097667204;
 Mon, 18 Sep 2023 21:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org> <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com> <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com> <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2023 12:27:36 +0800
Message-ID: <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Mon, Sep 18, 2023 at 2:55=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
> > From: Zhu, Lingshan <lingshan.zhu@intel.com>
> > Sent: Monday, September 18, 2023 12:19 PM
>
>
> > so admin vq based LM solution can be a side channel attacking surface
> It will be part of the DSM whenever it will be used in future.
> Hence, it is not attack surface.

DSM is not a part of TVM. So it really depends on what kind of work
did the admin virtqueue do. For commands that can't be self-contained
like provisioning, it is fine, since it is done before the TDI
assignment. But it not necessarily for your migration proposal. It
seems you've found another case that self-containing is important:
allowing the owner to access the member after TDI is attached to TVM
is a side channel attack.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

