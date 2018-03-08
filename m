Return-Path: virtio-dev-return-3477-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <1520304620-10753-1-git-send-email-changpeng.liu@intel.com>
 <20180307112855.GB16861@stefanha-x1.localdomain>
 <FF7FC980937D6342B9D289F5F3C7C2625B6161B4@SHSMSX103.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b479a6b-2863-e940-19b2-283b925cc3f0@redhat.com>
Date: Thu, 8 Mar 2018 14:04:44 +0100
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B6161B4@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v3] virtio-blk: add discard and write zeroes
 features to specification
To: "Liu, Changpeng" <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cavery@redhat.com" <cavery@redhat.com>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>, "Harris, James R" <james.r.harris@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/03/2018 02:01, Liu, Changpeng wrote:
> 
> 
>> -----Original Message-----
>> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On
>> Behalf Of Stefan Hajnoczi
>> Sent: Wednesday, March 7, 2018 7:29 PM
>> To: Liu, Changpeng <changpeng.liu@intel.com>
>> Cc: virtio-dev@lists.oasis-open.org; virtio-comment@lists.oasis-open.org;
>> cavery@redhat.com; pbonzini@redhat.com; Wodkowski, PawelX
>> <pawelx.wodkowski@intel.com>; Harris, James R <james.r.harris@intel.com>
>> Subject: Re: [virtio-dev] [PATCH v3] virtio-blk: add discard and write zeroes
>> features to specification
>>
>> On Tue, Mar 06, 2018 at 10:50:20AM +0800, Changpeng Liu wrote:
>>> +The \field{data} used for discard or write zeroes command is described
>>> +by one or more virtio_blk_discard_write_zeroes structs. \field{sector}
>>> +indicates the starting offset (multiplied by 512) of the segment, while
>>
>> Did you mean "divided by 512 bytes" instead of "multiplied by 512"?
> I saw the original expression for `sector` field used "multiplied by 512", so here just
> follow it, should here use "expressed by 512-byte", maybe this looks more clear to
> readers.

Actually the existing description of the "sector" field is wrong too.
"in 512-byte units" is probably the best way to express it.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

