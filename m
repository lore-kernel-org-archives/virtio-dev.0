Return-Path: <virtio-dev-return-9108-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B52A7986471
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Jan 2022 08:39:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <1642470583.2685027-1-xuanzhuo@linux.alibaba.com>
References: <1642470583.2685027-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 18 Jan 2022 09:39:04 +0100
Message-ID: <87h7a1v3o7.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v8] virtio-net: support device stats
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

>> > > above you said bytes sent.
>> >
>> > I mean, all about GSO are statistics based on big packets. So here is the
>> > package from Guest, and rx is the package passed to Guest.
>>
>> it's a subtle distinction that we need to make.
>
> I will make this clear in the next version.

Given that there will be a next version, would you like us to withdraw
the vote for the current version?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

