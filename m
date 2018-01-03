Return-Path: virtio-dev-return-2902-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BE5AB58191B2
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 12:43:22 -0800 (PST)
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
 <db20b680-e7c8-6563-ebd7-27ab7e06ad6a@linux.vnet.ibm.com>
 <5A4746F3.6090201@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 3 Jan 2018 21:43:09 +0100
MIME-Version: 1.0
In-Reply-To: <5A4746F3.6090201@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <41e46c1a-025f-7d03-50ac-c29e008fb9d8@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, Cornelia Huck <cohuck@redhat.com>, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/30/2017 08:57 AM, Longpeng (Mike) wrote:
>> What you actually do is the following. You define a
>> 'VIRTIO_CRYPTO_F_<SERVICE_NAME>_STATELESS_MODE feature bit is negotiated'
>> (A) mode and a '... bit is not negotiated (B)' mode for each service. 
> 
>> In
>> mode A the driver has to use type A sateful requests (to which you refer
>> as session mode).  In mode B however the driver can use both stateless
>> requests (to which you refer as stateless mode) and B type stateful
>> requests (to which you also refer as session mode).
> Sorry, I think the driver can use both in mode A and has to use stateful mode in
> mode B.
> 

You are right I've mixed up A and B. I think you got my point despite
of this slip up. 

I'm on holiday this week. Will try to review v23 next week.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

