Return-Path: virtio-dev-return-2798-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5910B5818F97
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Dec 2017 05:54:49 -0800 (PST)
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
 <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
 <5A2E8067.4050000@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 14:54:25 +0100
MIME-Version: 1.0
In-Reply-To: <5A2E8067.4050000@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/11/2017 01:56 PM, Longpeng (Mike) wrote:
> 
> 
> On 2017/12/6 19:01, Halil Pasic wrote:
> 
>>
>>
>> On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
>>> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
>>> +ZERO for the session-destroy operation.
>>
>> This ain't correct. It should have been something like virtio_crypto_destroy_session_input.
>>
> 
> Hi Halil,
> 
> I already fixed this just now.
> Do you have any other comments on v22 ? I'll send v23 tomorrow if no. :)
> 

Did not read the rest of the document. I'm not in the middle of something,
but I wanted to read the operation part these days. I guess, you prefer
sending out v23 over waiting, so I guess I will wait for v23 then.

Some general questions/remarks before you spin v23:

* I'm not convinced about this 'header' and 'extra parameters' terminology.
Please see https://en.wikipedia.org/wiki/Header_(computing) for header.
I don't think it's fitting for the _flf structs. 
Same about the 'extra'. Please see  https://www.merriam-webster.com/dictionary/extra
(a : more than is due, usual, or necessary : additional) the things in
_vlf aren't extra at all. Do you intend to stick with is terminology?
If yes why? Please explain how should I read/understand it so that it makes
sense!

* Do we want/need to specify any alignment requirement for the
stuff in guest storage (for instance the _flf fields) or be explicit
about no alignment should be assumed (e.g virtio_crypto_mac_create_session_flf.algo
ain't necessarily aligned (in guest memory) as required by uint32_t)?

* I assume one request is supposed to correspond to one descriptor chain.
Right? If yes, could you tell me, where is this expressed in the spec.

Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

