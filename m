Return-Path: virtio-dev-return-3590-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A6795819041
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Mar 2018 11:19:07 -0700 (PDT)
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
 <1514626559-162312-2-git-send-email-longpeng2@huawei.com>
 <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
 <20180316181953-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 19:18:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180316181953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <29aa3e9f-ae34-8888-4ec2-2fd22b4d747f@linux.vnet.ibm.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio
 crypto device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/16/2018 05:27 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 09, 2018 at 06:05:41PM +0100, Halil Pasic wrote:
>>> +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
>>
>> I can't find what happens if this limit isn't honored by the driver. Moreover
>> reading it is only SHOULD. Is it undefined behavior or should the device reject/fail
>> such requests? I think in qemu implementation we fail the request.
>>
>> This question is only about niceness. We are already good enough, IMHO:
>> since the implementer of the driver can't be sure what is going to happen
>> if the driver disregards max_cipher_key_len it is already an implicit
>> SHOULD.
> 
> I am not sure documenting undefined behaviour is always required.

I kind of agree. But I'm afraid I did not get through my point. It's
about clarity. The driver supplying a cipher key larger that
max_cipher_key_len isn't violating any driver normative statement.
I find it strange make obtaining a piece of configuration a driver
normative but have neither a driver normative that says the driver must
(or should) operate according to the same (at least in certain)
circumstances nor a device normative that implicitly educates the driver
implementer what happens if the driver is acting stupid (see below).


> We certainly do not do this for all other devices> 

"""
5.2.6.2 Device Requirements: Device Operation

A device MUST set the status byte to VIRTIO_BLK_S_IOERR for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT write any data.
"""

I was under the impression, that we sometimes express what is naively
a driver-requirement (e.g. thou shall not write to a read only
device) as a device-requirement. This has benefits in my opinion:
the driver implementer is educated about a certain behavior being a no-no
and hopefully leading to sane error handling (with a compliant device
sitting on the other side) --- instead of  offending drivers landing beyond
the spec (in undefined behavior land) by violating a driver-normative.

> Reading a field being SHOULD seems reasonable: e.g.
> driver might read it once and cache it in memory.

I don't quite understand. Let me quote the normative section

+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
+
+\begin{itemize*}
+\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
+    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
+\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
+\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.

[..]

+\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
+    the device supports.

Does it mean it's OK for the driver (e.g. after a configuration change
notification to use a stale) \field{max_cipher_key_len} ) as it is SHOULD read
bit it's not OK to use a stale \field{max_dataqueues}?

AFAIU all configuration space stuff eligible for caching, but
under certain circumstances the cache invalidates and a re-read
is necessary.

> 
> Halil, could you try to split your comments between requirements
> for more conformance clauses/clarifications as opposed to
> defects where it's wrong and does not match actual or
> expected behaviour?

Yes. I'm already trying to tag my comments. 'This question is only
 about niceness. We are already good enough' was supposed to indicate
that this one is not requirement.

Do you mean putting these in separate emails?

> 
> I think spec is better off with some documentation for this
> device than none at all like today.
> 


If the rest community says it's good enough, I won't fight against
inclusion neither in the repo nor in the next Committee Specification.

I would %100 agree with you if this were normal documentation.
The problem with standards is that both correctness and completeness
are crucial. What is not part of the standard, is not part of the
standard and period.

Virtio is especially tricky as there is no versions of the standard.
What once was a compliant device/driver must be kept compliant when
we change the text. That is why this better something than nothing
does not entirely work for me.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

