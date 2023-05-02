Return-Path: <virtio-dev-return-12488-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9603C77B73
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EEC273F56B
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:17:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFCF29864A4
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:17:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D13BF986486; Tue,  2 May 2023 07:17:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B851D986479;
	Tue,  2 May 2023 07:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtDT1v6N7kRpUMfF3byf0ZyO8yQTdpCFu076nxdCRXx6r4lxU1cACzxDxp5Rvxkyw+rq5EB2y1PxSvp13r0+HnRbS33j0JJZ/EbwoL1nbYz/2QAcL4veneyDCfmTpBlPA7INniYoWAqq/5dbJKadg2k1NpW0IrP3AMxxvdaALCAcGZ0s//muoqXUa7rzTFi3egCWBB5H0EZEHmCRnjmmuHbczJf+n7uttsUdmgnTwTN0ixNATRkDG36AnM6uv3CNu54khpCtyGQiqi5qpSTrvDVaFieAkSglrvqN0lrJMH4eVyhxXuwZyPvMVBdX3C3w39upOFmPK8Sxa1cTUBdHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8kJlg/Qqq5xyByxaXW7WK+m7fNfnU1l0d9YYez0tYE=;
 b=eIRDd9/Jcrz6MbV4FRCaBrDtH4wPiTxgyt5qYFQdEO5yoUMafMtSv2xK/SkjNAQARFzc+T8dfJPn2Z0kOS11jMF48uN1mOj48VmnBt7tcIDJ/5mDAaRnV+mrlCN6F3K/Ie81YKsINNsg5iEYJ+nIWDyeMKc0Nu4i9Y9Zj16GDZ6RbQgr11l6xGk8OkQ3aZ3XDwhJ8Sxwzfj7In60+n8KchLt5hQaSX0fVCUXgfgooWZYBVDVc2veShujYhNsLb/BJA0zbHiGIj3faycj4Gpr5x/CtKA9Rg99aSJhbtk4+n4vavOUAFFG4h8BStMHqOacjwkJ0XS4K00dMBIXUCRZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Satananda Burla
 <sburla@marvell.com>
In-Reply-To: <f66589c5-63bb-0844-f128-a63d72a9d7ac@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <f66589c5-63bb-0844-f128-a63d72a9d7ac@nvidia.com>
Date: Tue, 02 May 2023 08:17:43 +0100
Message-ID: <m2a5ynw6aw.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dbafe1-a7b3-4ba2-3b39-08db4add556b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oJtCRHzzf1GztUZjRJuqm3X0pIoinxY+hvCr8V4hP00gYz3KOaH+3t6e2wG/fCtzkycl2pEHvs5B7XTa/rZEAkgn5sgsj8mbbOAyFlsl3wQVKo0OPorIxm8JS6Twg0nqm8IfY3ZFhdLPDR/q7GIzYp3N5nSzqSNYAU3p0TwgsI2F4izePTYzF3Sz02RW/vkXEqylyMOjXWj1DKnUHW8ktkR/Xu/0Uy4/OpCJm7oFTKEtgv5Q1wsQXutltgXPsFjjEZMfpMxagEmbngMM9lPRuLzVKnCA041SxnGlhYfqsseY3IpoS18Y1gTB3g7StwghEYiAaTupz/alfBLx+1SXgplm9fWBlbq+WruptFwAeKSFJaNenadNxU8XHEb9sBwaU/KTeb6jOWeh33S4Q1Cy3PW++hY/NRE8fPgzvYHymfl4Cpn3Yopf8cMHAEtbguRUOgiq9kMNVY5n/GPt0MIhA8Dx3m0Gbb34Q7Wi8YANbbILf3Rf6UDB/Qv/rZh5bZjqixbResN96tHxywMfmsfOsenfurBmSE0E5bIel4397v0Q8ANH1O1ORCW75BLsdrsCh1x+SsdL7SIvi8oMDj9oQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(86362001)(4326008)(66476007)(66556008)(66946007)(66899021)(6506007)(6512007)(41300700001)(36756003)(8676002)(8936002)(5660300002)(6486002)(6666004)(316002)(2906002)(44832011)(478600001)(966005)(38100700002)(26005)(53546011)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUxWMjNmYlpEb0l0QThYSHpFZnpiZ0o2bWl6ZTFUSDB1dml4OVFXRkxnd1JZ?=
 =?utf-8?B?bmN5T0tCVlBjVG9jcGVVQ20xT0NGM0NHdWhoZWt1bmhQQmFxNnZML3F0OEFy?=
 =?utf-8?B?N3lYYlB3LzM0bTZSVGlQd1JOVnkrTlpyLy9oNWpXN1FCcEVDajZWVEd0UWFB?=
 =?utf-8?B?SkkzTWxIUjg3bmhRNUlXeHpOWEpuQmVPYXh4M3B5U2RkODlpbisrRmRwN2hD?=
 =?utf-8?B?eklSNVl4Y2ttb01pWmhwUnAxNkowdVR1azl6eFJIZ3RJYTRuZTZMWDlsdmRE?=
 =?utf-8?B?NnFiMDlRbjEvemJKRzBBMzhrUkVPWEVsdHN2SFExK0kxTTUreDBJU0VhbjZV?=
 =?utf-8?B?VlN1YWFUN1pFSmZTSzYwTWxndVRQM3QyVFRlajBlY1VOQjJYMkc0TEN6L3JK?=
 =?utf-8?B?VGpGUTNJQ0J5N1B3dzExdVlhMXR1YThRYzFzRDIvVmtmMUNuRFZ1UGhwSjJ0?=
 =?utf-8?B?SGxUNzg1Q0lWSzFIVTVFWityOXdBeHlWSjR0ZXc4emtheWxkOFVGM0dBQk9F?=
 =?utf-8?B?cFJtY3Q3UFBCcDNOMEhIV3FIVjc4SnNRNERDQW1XN0p1ZkZFcmtpZU05RkhI?=
 =?utf-8?B?dmsrMm9XZVZLMDhDZHQ0RjhRaFpiZ1p4M1AweE81UnBpQUJ0bkNlZFk2ektu?=
 =?utf-8?B?OTY0dnY3cmhaVlQxRU1aRDNzN2c2bDdSR01INkZCUUNGL2xsY2g3OHNsM1U3?=
 =?utf-8?B?UVc4dFFjc292VGhPQ0xpSUFTMFRXcEEzM0dSSkJJZDVqSjFISW93Q21KaUVv?=
 =?utf-8?B?cDR5SDh1S2xaQlJOVGZUejFQY0xiUEJnQVArRzR3dnd4bHE4MTA3ZmRWS1pL?=
 =?utf-8?B?SEI1dWZEMEExWnZoNFlIdmtPM1F2VytrTk9pSnJFVVY3c2t3Tm82SjZiMjNa?=
 =?utf-8?B?UnhGVWhWMEswYmZwNVVIUmlPcVB3YUhTSGZmTnQvbkRObXJKemxWcTNVYWRO?=
 =?utf-8?B?TkVJRHdDZVdDSk9EdDFlZXpTSVpEYStSR1hOWTFKV0hqVEhGLytRMGZPU2hr?=
 =?utf-8?B?Y2ZHMDRRU3lOSTFLOHJDRHVxbDltS3N5YU92cDdGZklZQ1JvSDgyUVhNbWFN?=
 =?utf-8?B?aW9vRzE4RkJKUis4MDR6NjMvZlo3SEV1U3Y2clc1MkNVOGxVNW9XamlEUG5L?=
 =?utf-8?B?eDl5bjk1cnd4dTNIS1NiMHZnRzR4MjE3cXJFV1l2N09UYlNXRGNIVXVMRlg2?=
 =?utf-8?B?a05zbGc1REZQd1BwakhuVVlWbHlWTXh1bjNyNEtPa09pUWZQMUFpUm5JUEcv?=
 =?utf-8?B?MHZEK3RrWlY3MmI2aDRkUXNSR0JIR0hOQS8yU2VRK2s3ZGd5QmlYTjZod1F0?=
 =?utf-8?B?YUQ3aWJxTjdvdjA4WlNIZHMxcGVqWldUSVFrMTlWNDFNOVYzSjltc2hGQ3lt?=
 =?utf-8?B?R3FJRURCbnB3T0MrU21neXNDSlIzQVpWbUFmWFRsQkZpQ1AxTmR1QWw2V09I?=
 =?utf-8?B?VlZRZDhQZVR6c0NEMnBGZjRqNFJoMjRJUHlmdDBSOFFVNjA1OHJhMUNaWUFC?=
 =?utf-8?B?Y0xlSnVLSmtJKytNOFdBcjhSUVpQQnFGZHJGYmdPQnZPTzZLc1VXSmVRTDFZ?=
 =?utf-8?B?a2pyVUsxTk9ybXA3SmRaNG1ydndGTGhOSTRtZGlVZ1RmTnV2eTg4aS9vTU5h?=
 =?utf-8?B?RHV1TWx4eGd4cFROTUV4U3FzTUp6T0l4MFg0OXRGb1QrZU5Ec01ZSjN5Y216?=
 =?utf-8?B?RXF1SjZrclMyclJ3SmtCQlZKRVRYRjIzQlVGVzZhL1ZRQXBaazJ5NzdDWkZt?=
 =?utf-8?B?NXdPbVhYV0V5QmE2ZkVWbDkxd29VbUtFYkpJUEdvTnJNd0YxZkNJQ1gvV21H?=
 =?utf-8?B?VURPM3pvMHpnSGUyZUdkenhwVm9VektQQ01jVHBSZmZCUXhDUGxiTHUyUXBC?=
 =?utf-8?B?Ym9PTUl2anRCNW1uZ2pwcS9DaDdVTGkyUVVrd3BmOUIxVEl2Ny9YdE03L0pU?=
 =?utf-8?B?TkZhUU5jbEYxVHpZTS9mdG5OaExlWnBIa1pLMEhVZVRpbTRaODFlZmtzS0d3?=
 =?utf-8?B?ZURkcWt4bm81NVpWN3NINlpuVzRlUWxHMEsyQnowdUlrdE9iMXQzMXZVRVI5?=
 =?utf-8?B?Z2FhMFJ2d3hQWm1Oc0xWNmFYdW5SZXU5QmY0NzA1dnNZL3J6cTVmMXp1V2xu?=
 =?utf-8?B?MkJhVDFUTzhEbzVYWWdHM1RDSi9VNzBWWUlBdWxJcG1XcGxpLzY2VkdDbFU2?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DaMpIrPcKIuezeeT2X0fI6Zaa+jLBakinJirEnsIZjb+r2q6mcCmunRee78BYW1p/lkFmxbO4l5QVgBiEDceQcbQLO2nFM7VO1EQ2CN/TYIkSetoU4xO0+pYll3DtWtF99F3q3Yztsw1dxUl7VdkV/lIUs0ngWo+/1mqgmHipgs0GVJ39FWS/RDBCDmGFUnBmIix1TygcTiQiBrVOXK+PM2QwKK1Pt0bB060dfpZZle2icLmlRgYlLaEP3er1Fws0bHbo8jxClhe/Zc4ssJDINe9+qCoQkrQRsICzqAjUR/8ErikCfVWfmR5o3PLKyoaaq2WlXdzS5oquYS4V6T/MqfRsvqkAGd84ewTT9Ed+uCV+44vVRFvm0WTz+j9G3wIzkge1I+isAKuKrhSDMxflRIvw8GtnQ2yYL71S8Nz/7IWcavc0eKqvPcJsCEFmQe9laT96Ds32H+oYMCgulmMuKHn6iu9liSbGkSCiyaE0KPn97+A7PJpL1qJUANdMYIqBkR0//Fa9HaB2Rv/8bbJf/2H03EzwnHsBxXqjasttCNANJNJekZlRFtoqeA18MSOgXq+ySQnFk5P6RDxyQpnCMWRbzcI/pqXhmS1yqPc6ptAPtfssQa8ae8Fp5b6qScS+81Q7JSLt5Z7uinTIeIid3NfwAH9YuAJI5QzEgjf0HkCFbRA/O0cfrKgZVmQOt+p9AhL5TW0tBwPSZyWdkmu54egm8k7Dd0d3kH+a+d4etYeu/jIy4UvRrhUgswgpYT6fberWlcbwNNblhS9a3UEpgGqYlpwfgPLd36LATifAhiV1fw/PxY/kq5oU7NoJsYIuO0U3c5OCVg5QkebIkdYbvGIOs1FvgkqP3nK68R64eQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dbafe1-a7b3-4ba2-3b39-08db4add556b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 07:17:48.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjIeglpF5pFk4A/J2toNtKW4LmKqa0/CBr4AShT99vxWAThl9YPtpeJ72wHIQVk6umWQiQ5FqluvKHdt5I8Ex/QTsTR2V+U4bn2D+i7jERg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020063
X-Proofpoint-ORIG-GUID: qsnECWlwcQlspLY6bhZtdYZyCJmjQOPO
X-Proofpoint-GUID: qsnECWlwcQlspLY6bhZtdYZyCJmjQOPO
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device

In line with our recent discussion about agreeing requirements for
specification changes, I wanted to say that we have a significant
existing estate of VMs using the legacy interface where the customer is
disinclined to update their software to a newer version (which might
consume the 1.x interface).

Given that, some mechanism for supporting a (mostly) hardware offloaded
legacy interface would definitely be useful to us, and the proposal here
seems like a sensible approach.

We are aware of vDPA, but that comes with its own challenges.

Parav Pandit <parav@nvidia.com> writes:

> On 3/30/2023 6:58 PM, Parav Pandit wrote:
>> Overview:
>> ---------
>> The Transitional MMR device is a variant of the transitional PCI device.
>> It has its own small Device ID range. It does not have I/O
>> region BAR; instead it exposes legacy configuration and device
>> specific registers at an offset in the memory region BAR.
>>=20
>> Such transitional MMR devices will be used at the scale of
>> thousands of devices using PCI SR-IOV and/or future scalable
>> virtualization technology to provide backward
>> compatibility (for legacy devices) and also future
>> compatibility with new features.
>>=20
>> Usecase:
>> --------
>> 1. A hypervisor/system needs to provide transitional
>>     virtio devices to the guest VM at scale of thousands,
>>     typically, one to eight devices per VM.
>>=20
>> 2. A hypervisor/system needs to provide such devices using a
>>     vendor agnostic driver in the hypervisor system.
>>=20
>> 3. A hypervisor system prefers to have single stack regardless of
>>     virtio device type (net/blk) and be future compatible with a
>>     single vfio stack using SR-IOV or other scalable device
>>     virtualization technology to map PCI devices to the guest VM.
>>     (as transitional or otherwise)
>>=20
>> Motivation/Background:
>> ----------------------
>> The existing transitional PCI device is missing support for
>> PCI SR-IOV based devices. Currently it does not work beyond
>> PCI PF, or as software emulated device in reality. It currently
>> has below cited system level limitations:
>>=20
>> [a] PCIe spec citation:
>> VFs do not support I/O Space and thus VF BARs shall not
>> indicate I/O Space.
>>=20
>> [b] cpu arch citiation:
>> Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual:
>> The processor=E2=80=99s I/O address space is separate and distinct from
>> the physical-memory address space. The I/O address space consists
>> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFF=
H.
>>=20
>> [c] PCIe spec citation:
>> If a bridge implements an I/O address range,...I/O address range
>> will be aligned to a 4 KB boundary.
>>=20
>> [d] I/O region accesses at PCI system level is slow as they are non-post=
ed
>> operations in PCIe fabric.
>>=20
> After our last several discussions, feedback from Michel and Jason,
> to support above use case requirements, I would like to update v1 with=20
> below proposal.
>
> 1. Use existing non transitional device to extend the legacy registers=20
> access.
>
> 2. AQ of the parent PF is the optimal choice to access VF legacy=20
> registers. (As opposed to MMR of the VF).
> This is because:
> a. it enables to avoid complex reset flow at scale for the VFs.
>
> b. it enables using existing driver notification which is already=20
> present at notification section of 1.x and transitional device.
>
> 3. New AQ command opcode for legacy register access read/write
> Input fields:
> a. opcode 0x8000
> b. group and VF member identifiers.
> c. registers offset,
> d. registers size (1 to 64B)
> e. registers content (on write)
>
> output fields:
> a. cmd status
> b. register content on read
>
> 4. New AQ command to return q notify address for legacy access.
> Inputs:
> a. opcode 0x8001
> b. group and VF member identifier or this can be just constant for all VF=
s?
>
> Output:
> a. BAR index
> b. byte offset within the BAR
>
> 5. PCI Extended capabilities for all the existing capabilities located=20
> in the legacy section.
> Why?
> a. This is for the new driver (such as vfio) to always rely on the new=20
> capabilities.
> b. Legacy PCI regions is close to its full capacity.
>
> Few option questions:
> 1. Should the q notification query command be per VF or should be one=20
> for all group members (VF)?
>
> Any further comments to address in v1?
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
--=20
And you're standing here beside me, I love the passing of time.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

