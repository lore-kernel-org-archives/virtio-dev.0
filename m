Return-Path: <virtio-dev-return-9342-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1274C986497
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Mar 2022 03:30:33 +0000 (UTC)
Message-ID: <34935c59-1267-034c-ecdf-703e4da57f7a@redhat.com>
Date: Wed, 2 Mar 2022 11:30:21 +0800
MIME-Version: 1.0
References: <20220301083446.55424-1-xuanzhuo@linux.alibaba.com>
 <20220301054557-mutt-send-email-mst@kernel.org>
 <1646134343.8491874-1-xuanzhuo@linux.alibaba.com>
 <20220301071913-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220301071913-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support device stats
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/3/1 =E4=B8=8B=E5=8D=888:25, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Tue, Mar 01, 2022 at 07:32:23PM +0800, Xuan Zhuo wrote:
>> I have to say, this design is really good.
>>
>> I think one of the core points of your design is to separate drop stats,=
 gso
>> stats, etc. Get the stats you want based on negotiation and needs. And c=
overing
>> the control queue, I am very surprised.
>>
>> But does this design solve the problem of expansion? Various stats indep=
endent
>> structures seem to be convenient for expansion. But is this expansion re=
ady for
>> dynamic negotiation?
> For negotiation, we can either separate feature flags for each supported
> type, or do like RSS and add commands for querying supported types
> and enabling stats collection.


I think new command would be better but I don't understand why we need=20
the logic of enable/disable?


> Features is probably easier
> for now ... Also, do we need to enable/disable stat collection?
>
>
>
>> My earliest solution is dynamic negotiation, that is, the driver tells t=
he
>> device how many stats it wants to get. And the device negotiates how man=
y stats
>> it should give to the driver based on this information of the driver.
>>
>> But that's not great for migration. So gave up.  @Jason
> Any optional feature is problematic for migration, at least with
> features device knows ahead of the time what does driver
> want to use.


If we tie e.g RSS stats command to RSS feature, we won't have any problem.

Thanks


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

