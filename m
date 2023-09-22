Return-Path: <virtio-dev-return-13937-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970E6E7D0CE
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 12:30:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D275D2B02B
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 12:30:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1BDD9866B3
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 12:30:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98E0F9866A2; Fri, 22 Sep 2023 12:30:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85D9E98669F;
	Fri, 22 Sep 2023 12:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="6.03,167,1694736000"; 
   d="scan'208";a="365265190"
Message-ID: <b6835abd-0544-4dbe-a914-c42f325834b6@amazon.es>
Date: Fri, 22 Sep 2023 14:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, <aams@amazon.de>
References: <e738e7f0-dd13-44db-806c-543746aa6967@amazon.es>
 <20230913053707-mutt-send-email-mst@kernel.org>
 <d7d17e9f-e6ad-4106-a408-99281382a93f@amazon.es>
 <20230918083722-mutt-send-email-mst@kernel.org>
 <e75d9667-2ea0-44d0-a26f-fa3d5fe05651@amazon.es>
 <20230918091506-mutt-send-email-mst@kernel.org>
 <a22ba2cb-9b03-481a-b66e-0b78fbfb21f0@amazon.es>
 <20230918100355-mutt-send-email-mst@kernel.org>
 <4ab1b10e-4524-4b6c-a3df-863360fd225d@amazon.es>
 <c2e7076b-b07e-43cd-a912-9314d742a678@amazon.es>
 <20230919055811-mutt-send-email-mst@kernel.org>
 <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
Autocrypt: addr=bchalios@amazon.es; keydata=
 xsFNBGIonY4BEACl1/Qf/fYoDawcFfvjckR5H2yDxlBvKoFT4m5KYiRUivcf5nwCijrM3Fij
 d38MBpMb9kvwN7lAXOXPCBZMhaNH3J3NuFpUCIZ+UZtf5JgDGiKd/Obli/c0m+7du8wEysCD
 Z1ldpDeW3c9aENw/uUChQkTEEh0Cmj83uVYEz+BMJKmeA/1Qz0kzGp/MkW8mZYVY5ts4PcBq
 UmH8Qm5x9NqspTMqIj/yUyxFgxRcKzBOPCF7KiabuCNGCWJAL3EN4SQIQ4MsLBJOSyk5RazC
 5x4Vdt9+oCq+jD6H5S19FBSiXKDZCFitIQYd9Xj3Stw6jgrObWrn4ll3aT/XCMYF0Ja8x9+S
 /UfYEGEPOJkrelKqAu1721LcBwG1rPp12uzyTmtwWBIeDp15/ZnxZ5IG1HuNSsoZzjjnhiLY
 ECfIymLMya2ofSk4ENCbAdmCAmuI5Fe5ZcUR5zjKHIN5aTgPYEf0H17iZMZlhJ7tAFFKnaGR
 gMzPiJaff1B8fJjaRd6S73f+4hK0elXAAphoeg8nM2EQQAEzIqSocAZgiktsTbfDSuvCFjrc
 NP3/R5gWdJDbhlMGP+bhs6HclywzkahskxEQtHo4C1tjP5XFxmUhYlJWJHncDJa4jlouo3zo
 1h1NE3OPbT1HDj8O69GXcNZop10hMbnlrIYb3HfJEpTIudYPGwARAQABzSJCYWJpcyBDaGFs
 aW9zIDxiY2hhbGlvc0BhbWF6b24uZXM+wsGSBBMBCAA8FiEEDnV+NQfr1LBsLB/GjBB7GAqe
 ZsQFAmIonY4CGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJEIwQexgKnmbEK2AP
 /3E4c+xwberE/Sczr5YtO2NZDOnJ0ksumNBJYwJxVNvZEKG1tzJ03oxAE7v0xNylCXSV+tEk
 WUxuwcyeisQwfwlhhG3upW0ErvpLqhhWXZQYV2ogI3ZJ54oBuFqCkHQ5MOlIApUI5jR6rzY4
 0i8c+1DWL3VI4Jmj8+QRfLxPbade81Rj7j/jc7qTsyzfs4SVRQQo2AF6VBIqNh9MFwJzeX4a
 8INhNwchKpt8xUfRSSR5Q/FhrS4drUaG4Hi+dL1aPLWpo9zvFCJQpOeDQysrIyQ7m8VZO0cn
 Iqh6vnfJrcx4vxQB19XJHM6sufmHLfEy/gZAXplq1YPpuzy6m0Kj5oUABRsAQDPulSndV2qL
 d8cgAgVei/SEhl6qDmNQqtTK3GeqgdyUHvIYD+MyzTsDplSiA2wvLVdbeltPdi+KmA7kyE7B
 qthH1H7AMr8IOqBNUS6oVNGD72Bg5qEenhiUgMI287UyGPz3TxAPdwc3TFCxHaJeNhLpi1Db
 F2tdIxBlwtbwHI9ah24lpmDyO+nttbXv6wJWgg4oV2Dw7lgYh2t9YBnQvI3xO+c2AbDwBEOe
 9daTNJYVnjboCPjF/HiJAJh2aurno5Da72gyRsEf3cl/R5rIIx2ZfZVwk88MTZSe4dwsu2NV
 l6yT6DyyLWdZcSjmkLuuW92THzlkZlpQ0EDqzsFNBGIonY4BEADCxlifRJR46flvWYp6xRjp
 pppGljP69wCJQSGdOSQj2KwIZbqwI36NCW8zCXAYUrpMqNhsp2pc1IUnv7P9HBitx4t8XCMV
 Cj+ZRXOZs3fGvYxOH433+UuDt4bC7Nazq6fFJkdUgZoivXOqzJpLmjSTtxJBnbv/CFmo7tgM
 PG+gHZUzlwATc4iYqc23OKHyaVA1OecU4CJoVKLP0vwO/xaSEs7jL0MYHqSYTBN/63A9Xqt3
 JBLUuwGs1a936xXq1/MMLWRAP1N5XGL0S7oOF9TM2trq2GISaBVenjpWhT11X+q67y3cFxbb
 oETa14ggq9QKorgXVgYWUa7Jq5hBlRiJQeR+gAa8jUTIU0c7psgz24CEwC1TDx9TpDz1BMIn
 /zEF8g7j8nZlqiph5qyqbSc9iayhtf2FG0aYNBEzgybKoR50qEIM82pHCeJSYZxpPILdCVWn
 tntD+h22IJFHgXihCYPYkHa//Nyb2+Alh2hBsRulQWNRyubG+HZvW/Mre7kyVbJi+ajEkx6K
 /pbxWbJlDp2ozgnDRTf+7/xCKVP9jO2Y6JjrRx8WAlqYSjK16ML9w1hxZepekeOXhNxGxhEH
 Z5lzVEVdbHQUN69ZFOcjZnf87vMZBcPxzebcydzRs96CFYsEkT34C9SnElejzuNmN5fMfrJ9
 713Mj0/MdpcjPwARAQABwsF2BBgBCAAgFiEEDnV+NQfr1LBsLB/GjBB7GAqeZsQFAmIonY4C
 GwwACgkQjBB7GAqeZsR2Lg/8CIRvePonn3me+500Zdyv3Z3yaIkHv9mArCLPOzh0mhwrWQWh
 e5oLnTx51ynU5kUow0i3Owj6xu972naqpV/c0olGdNrwrYboKM3DMHrdZr/pqGhWckU+8S2T
 uCVB3c/b8YRxqXww5GhwV1WwFC4sndc86tl1yKpxpDdQ858uZYs33Ur+WmxJJQ5BD6sQ48OD
 5hEseFrcbikSKk/eVD1FrT3lzbaVqqvQ71soCYYuo2VKxmShuQxUeeFp8hnDw3TR5SO1KJft
 CT6sQ4dS3vUDeKzVu8E2ofGyOQZ9j6KlFz9daBiRHowFON1vZKS/k8A7ZCZ5Co3Skx538GW8
 jDNZJgnSbaam8FVDT1z2H6irmEHz1/vb3hZns0bAmqgwWONTW/gO5jcPbzbTqPfIlmCEtBDf
 qGaQH7uIyC5kPMTQCNvEMKKn/R2hV3al2/gLvRYFI1GGFE/QdLXiYXmtkDBaz/niHxUUGqO4
 LbSF+KYpZYewC8Wx5gTr4Glj+9+RcDWzdkGBd+Kthh0VIOdalbjbnv2jmt5gvLoeLDNpIZRQ
 AQ+HulTHw5frK1j8+AHIKQYXIE8xXzVkssNuX0Hc7ecC5jm/XlGr5IuQkJpFyVtiXfjkd6tq
 9CfKbXmQEUz/yWPkXerBltQSv7ePqJHPFMwJrFAqFftGK6t9nvzGjQB91RM=
In-Reply-To: <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.95.88.160]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

Hi Michael,

On 19/9/23 12:11, Babis Chalios wrote:
> On 19/9/23 12:01, Michael S. Tsirkin wrote:
>> On Tue, Sep 19, 2023 at 09:32:08AM +0200, Babis Chalios wrote:
>>> Resending to fix e-mail formatting issues (sorry for the spam)
>>>
>>> On 18/9/23 18:30, Babis Chalios wrote:
>>>>>>>> Yes, that's what the driver does now in the RFC patch.
>>>>>>>> However, this just
>>>>>>>> decreases
>>>>>>>> the race window, it doesn't eliminate it. If a third
>>>>>>>> leak event happens it
>>>>>>>> might not
>>>>>>>> find any buffers to use:
>>>>>>>>
>>>>>>>> 1. available buffers to queue 1-X
>>>>>>>> 2. available buffers to queue X
>>>>>>>>
>>>>>>>>
>>>>>>>> 3. poll queue X
>>>>>>>> 4. used buffers in queue X       <- leak event 1 will
>>>>>>>> use buffers in X
>>>>>>>> 5. avail buffers in queue X
>>>>>>>> 6. poll queue 1-X                <- leak event 2 will
>>>>>>>> use buffers in 1-X
>>>>>>>> 7. used buffers in queue 1-X
>>>>>>>> 8. avail buffers in queue 1-X
>>>>>>>>                                     <- leak event 3 (it
>>>>>>>> needs buffers in X, race with step 5)
>>>>>>>> 9. goto 3
>>>>>>> I don't get it. we added buffers in step 5.
>>>>>> What if the leak event 3 arrives before step 5 had time to
>>>>>> actually add the
>>>>>> buffers in X and make
>>>>>> them visible to the device?
>>>>> Then it will see a single event in 1-X instead of two events.  A 
>>>>> leak is
>>>>> a leak though, I don't see does it matter how many triggered.
>>>>>
>>>
>>> So the scenario I have in mind is the following:
>>>
>>> (Epoch here is terminology that I used in the Linux RFC. It is a value
>>> maintained by random.c
>>> that changes every time a leak event happens).
>>>
>>> 1. add buffers to 1-X
>>> 2. add buffers to X
>>> 3. poll queue X
>>> 4. vcpu 0: get getrandom() entropy and cache epoch value
>>> 5. Device: First snapshot, uses buffers in X
>>> 6. vcpu 1: sees used buffers
>>> 7. Device: Second snapshot, uses buffers in 1-X
>>> 8. vcpu 0: getrandom() observes new  epoch value & caches it
>>> 9. Device: Third snapshot, no buffers in either queue, (vcpu 1 from 
>>> step 6
>>> has not yet finished adding new buffers).
>>> 10. vcpu 1 adds new buffer in X
>>> 11. vcpu 0: getrandom() will not see new epoch and gets stale entropy.
>>>
>>>
>>> In this succession of events, when the third snapshot will happen, the
>>> device won't find
>>> any buffers in either queue, so it won't increase the RNG epoch 
>>> value. So,
>>> any entropy
>>> gathered after step 8 will be the same across all snapshots. Am I 
>>> missing
>>> something?
>>>
>>> Cheers,
>>> Babis
>>>
>> Yes but notice how this is followed by:
>>
>> 12. vcpu 1: sees used buffers in 1-X
>>
>> Driver can notify getrandom I guess?
>
> It could, but then we have the exact race condition that VMGENID had,
> userspace has already consumed stale entropy and there's nothing we
> can do about that.
>
> Although this is indeed a corner case, it feels like it beats the purpose
> of having the hardware update directly userspace (via copy on leak).
>
> How do you feel about the proposal a couple of emails back? It looks to
> me that it avoids completely the race condition.

Any thoughts on this? Sorry for pushing. I want to finalize the details 
on this,
so I can close open fronts on the LKML patch.

Cheers,
Babis

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

