Return-Path: virtio-dev-return-3956-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B6D4E1CB80F2
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 11:27:13 -0700 (PDT)
References: <1524071419-32187-1-git-send-email-jonathan.helman@oracle.com>
 <20180419092433.GA4327@stefanha-x1.localdomain>
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <f3662a7f-df86-f176-fc03-9ef9815e32b8@oracle.com>
Date: Wed, 25 Apr 2018 11:26:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180419092433.GA4327@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: document hugetlb page allocation
 counts
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mihai.carabas@oracle.com, mst@redhat.com, jasowang@redhat.com, Thomas Tai <thomas.tai@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/19/2018 02:24 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 10:10:19AM -0700, Jonathan Helman wrote:
>> The Linux kernel exports the number of successful and failed
>> hugetlb page allocations via the virtio balloon driver. These
>> two counts need to be documented in this specification.
>>
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
>> ---
>>   content.tex | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Thanks. Do I need to take some action, like adding a tag to the github 
issue I opened?

Jon

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

