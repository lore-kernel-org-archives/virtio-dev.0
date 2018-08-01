Return-Path: virtio-dev-return-4763-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E59E3985CD7
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Aug 2018 20:21:40 +0000 (UTC)
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
 <1514626559-162312-2-git-send-email-longpeng2@huawei.com>
 <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
 <5B51CF0B.8020706@huawei.com>
 <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
 <20180727144726-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 1 Aug 2018 22:21:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180727144726-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <47e5bc06-6b4d-aab6-db77-c91313d36d87@linux.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] Re: [v23 1/2] virtio-crypto: Add virtio
 crypto device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: denglingli@chinamobile.com, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, Jani.Kokkonen@huawei.com, xin.zeng@intel.com, wangxinxin.wang@huawei.com, liang.j.ma@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, "Longpeng (Mike)" <longpeng2@huawei.com>, vincent.jardin@6wind.com, jasowang@redhat.com, weidong.huang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 07/27/2018 01:51 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 26, 2018 at 06:55:44PM +0200, Halil Pasic wrote:
>> Sorry I did not have any time for this last days. And this
>> to make it worse this is a follow up to something that was
>> half a year ago. That means I have to re-familiarize myself
>> with the topic.
>>
>> If I don't get around to answer in couple of weeks, feel
>> free to ping me.
>>
>> Since from what I've seen most of the questions were of type
>> 'Can we do it like this?', maybe sending out a new version
>> is the best. So people (like me) can read through the whole
>> thing and point out problems if any.
>>
>> Regards,
>> Halil
> 
> 
> While two weeks for review is borderline reasonable as an exception, it
> does trouble me that  we are at v23, for something that is used
> in the field so it's not like we can just change things at will.
> So I hope everyone concerned makes an effort to try to converge on a spec
> ASAP.
> 

What I tried to say: I'm busy with other stuff, and I'm not too
happy to resume a complex topic after 6 months hiatus.

The series is now at v24 and has apparently no acks or r-bs. I don't think
I'm the only one to blame for that.

It seems, I won't have the time to do a conscientious review in a
timely fashion. If the rest of the bunch thinks what we have is good
enough, I am happy to abstain when voting on this -- and avoiding
holding it up any further.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

