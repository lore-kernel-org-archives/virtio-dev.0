Return-Path: virtio-dev-return-5661-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50A74985E1D
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Apr 2019 09:12:10 +0000 (UTC)
Date: Thu, 11 Apr 2019 05:12:07 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1281031095.20992727.1554973927928.JavaMail.zimbra@redhat.com>
In-Reply-To: <5b0ca542-eec9-f79a-6b63-c07f375f3fa0@redhat.com>
References: <20190326143507.12607-1-pagupta@redhat.com> <20190410144245.GD9868@stefanha-x1.localdomain> <5b0ca542-eec9-f79a-6b63-c07f375f3fa0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-pmem: PMEM device spec
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, mst@redhat.com, riel@surriel.com, dan j williams <dan.j.williams@intel.com>, aarcange@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


> >> new file mode 100644
> >> index 0000000..04e07bb
> >> --- /dev/null
> >> +++ b/virtio-pmem.tex
> >> @@ -0,0 +1,134 @@
> >> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> >> +
> >> +The virtio pmem is a fake persistent memory (NVDIMM) device
> >> +used to bypass the guest page cache and provide a virtio
> >> +based asynchronous flush mechanism. This avoids the need
> > 
> > Is there anything "fake" about virtio-pmem from the perspective of the
> > device interface?
> > 
> > What you are describing is one use case.  But on a platform that doesn't
> > have existing physical NVDIMM interfaces, ACPI, etc maybe virtio-pmem
> > would be used to pass through physical NVDIMMs from the host?  If you
> > agree, then it might make sense to describe the device simply as a
> > persistent memory device and give "fake NVDIMM" as an example use case
> > in a separate paragraph.  This would make the text more future-proof.
> 
> Very good point. E.g. on x86-64, we might want to pass a real NVDIMM to
> the guest using virtio-pmem, if our guest VM e.g. has no ACPI configured.
> 
> In this case, it would be helpful to indicate if the flushing interface
> is to be used, or if other flushing (e.g. like NVDIMMs) is to be used.
> 

Yes. Agree. This is a very good point, will consider pass-through of 
real NVDIMM device for architectures don't support ACPI.

Yes, corresponding flushing mechanism should be mentioned but I am not sure
if it should be mentioned in device specification?

Thanks,
Pankaj   

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

