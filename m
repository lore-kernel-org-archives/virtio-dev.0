Return-Path: virtio-dev-return-5659-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73847985E03
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Apr 2019 14:56:35 +0000 (UTC)
References: <20190326143507.12607-1-pagupta@redhat.com>
 <20190410144245.GD9868@stefanha-x1.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5b0ca542-eec9-f79a-6b63-c07f375f3fa0@redhat.com>
Date: Wed, 10 Apr 2019 16:56:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190410144245.GD9868@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-pmem: PMEM device spec
To: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, riel@surriel.com, dan.j.williams@intel.com, aarcange@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10.04.19 16:42, Stefan Hajnoczi wrote:
> On Tue, Mar 26, 2019 at 08:05:07PM +0530, Pankaj Gupta wrote:
>> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
>> new file mode 100644
>> index 0000000..04e07bb
>> --- /dev/null
>> +++ b/virtio-pmem.tex
>> @@ -0,0 +1,134 @@
>> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
>> +
>> +The virtio pmem is a fake persistent memory (NVDIMM) device
>> +used to bypass the guest page cache and provide a virtio
>> +based asynchronous flush mechanism. This avoids the need
> 
> Is there anything "fake" about virtio-pmem from the perspective of the
> device interface?
> 
> What you are describing is one use case.  But on a platform that doesn't
> have existing physical NVDIMM interfaces, ACPI, etc maybe virtio-pmem
> would be used to pass through physical NVDIMMs from the host?  If you
> agree, then it might make sense to describe the device simply as a
> persistent memory device and give "fake NVDIMM" as an example use case
> in a separate paragraph.  This would make the text more future-proof.

Very good point. E.g. on x86-64, we might want to pass a real NVDIMM to
the guest using virtio-pmem, if our guest VM e.g. has no ACPI configured.

In this case, it would be helpful to indicate if the flushing interface
is to be used, or if other flushing (e.g. like NVDIMMs) is to be used.


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

