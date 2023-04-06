Return-Path: <virtio-dev-return-12034-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A38C7618D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:14:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D5B2C1FF60
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:14:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF97E98660E
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 04:14:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C11449865C8; Thu,  6 Apr 2023 04:14:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD5819865B7;
	Thu,  6 Apr 2023 04:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1IYUKL0Vza3LYZkGA7l+C97o1J5hX9IA6yu/hgcH3mZDEL3yNSLPnJ2m38CUdhdeiKYAyxYz+7sR9JS6HYvql93QVrIv7c/Y/BfnrYtldwf87kJ5DATH3d6E8/fpFrPf314nMYCRVmEA5V4SHEDUreQUZ/dBz+FtLe2NvwAuH9S6gKhsSMffXUX9JN0HKvJjwgPB5A47A4OblUe61lKp2sE8r6rzcfguttudTuaYh0DZKvVymW9D3K2FGQWBwgQWmepxDLKoiR0DvA5aitHPtw0VSMRA7IPq/4WPdiblc5o1HR7mhN2GqbLHjRn1zneX1wHPDe/GnGTNFHpLQ6zJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAkyEbI1yFA6M8oiXQWrjN7sCF9snr+IlB2aXRh813k=;
 b=VJBR2/UpfCexW1hgpP5XM+2xfWAU+pe0msra5yaAqDfE+qvQ3/b3jlFNKICIroSlhMTbfKT/a1toVxt9hOfCXA5Q/5SZMTnauzd5aJrY07CjHniKG2Mh+NGrtKDkrnvZhn9dq8U+Ei19hMXu8IUqW4cqMUiSyMkZyJCiER8EJ7sBho+WWhMdIqtzsKn9CS7K5WuiRqJ+n7LFWv5Exl5yyTyo15JeGmJO4TAKd4nr6TxX7o1EmsSWOpx0kzIILCqyjeBziqqAcVPl8Zb5+bxEPvmBuDTQ3it+HJs14u5jAP/0S/RjK4+9mg/rOQOLWvJr4n6xUNyYvX3GOQmySudikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <a69f2e1d-bf93-8f65-791f-510d2703cd9a@nvidia.com>
Date: Thu, 6 Apr 2023 00:14:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd7078d-9fa6-4cf2-36e2-08db36556ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c9SsykYok5ArNPBniVuJjrpJ07wvjFxFz5Lwk1z4uW65va391DYzTDU163oRMPwrvCykh5tH09D3pPnWsDZuNbZ4yzvTXMr2M7CDCaFbcx9UHRmGeXXqo/kFBvK99WKbwEv3Yctn/GkucVF0HqwNWFu8OsGC85pLJ4k+Ep78w59qREF3+F/t2hPiiPe1rBpMWRoWP7Hhs4BibtROV1Nn6XH4gn+bBEW3dbywzWx23hEF4YmHkRLFvMav7D9LP0erJRuhQOpy/MSmJvU6juL6pZc1yUe2QVKHnY0jOLIgd1rn0mMwDBsSYMa57T3Lujx3ZcspB03yHG+C7KL2QqkQoKnOEA8wCHv3UuqIGGZc9v0Oj97ItOQT/BVkq6MEySI4DYXfNOikQJz3gh8Jzrqeob7zKOY3rlHpVXyocfKM6CoI/FvyLZht1c4kp7E370ROhIpbqwK7EhUhbeagS9ED9qD8LcL6twDULcCBYygJgssAHzrifGt6oKyB3knV1Z1RzNsOXo7bCnI2iphTmY//a3Rt1bZvJhYJIJ52ZT8FT+GWSqLSRhg3fHZJFP0K56AXObAg+rdzOBD6jkwoks3BCHYc+NJutQokrRuWWsj/tID7vHs216mZEYvA98MLCGMR5S+PdF1KqoP21vSFi9CYmWCT94OseYtosuVl6su30Ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(8676002)(316002)(66476007)(54906003)(66946007)(66556008)(6666004)(6486002)(107886003)(4326008)(2906002)(5660300002)(7416002)(921005)(41300700001)(8936002)(38100700002)(86362001)(31696002)(2616005)(26005)(6512007)(6506007)(36756003)(186003)(83380400001)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmUyWUs2UUpqeHFyUk9QL1U2NWhDbFM0Q1ZTMTU3c1pjcWgrSTVkMG9GVE9p?=
 =?utf-8?B?WFZJM0ozNkQxUjhOc0NQZm9la2dwOSsrWHoxN29RSEZGclNTaHF6ajdHUHc0?=
 =?utf-8?B?N01ZR1BYUVVCS0FYWEprbmExeHNEK1VsNFJ4TWtQVUZkd1IrSEFHNnRUeFVN?=
 =?utf-8?B?L2xDYnNmY2xzd3ZpLzdLMnAvWUN1TUw4UnlQVmN5V2VnNUJsd2JGdmVxWGRw?=
 =?utf-8?B?Y0R4UlcyU0wxcWdYRmxKTmFXK0hvejc0UU12TS8rRWlLc1Q0aFZpRFNmSnc2?=
 =?utf-8?B?UmtTS1ppdldRb0FhSHVWbjcvbjNZR3BQcWxMWjVTcXdPQ2ZKQnFPNmNRYzJY?=
 =?utf-8?B?RnhHTFF3MFo1SWRTTDNFYnFycEhtakROTmFjc3pBdEI5S0pzVGJObDN5Q05z?=
 =?utf-8?B?VERDLzRXSUVxUFlEOHNiSEd2bGJNMnB0RThmUFA3Mkd4SEVKems1eGh0TTZI?=
 =?utf-8?B?REFISnhOdHpBb09DR0FrNWR2Y2gxUjF3UkJuVUJuSk1pamFPTXZ2R3ZTR1ZY?=
 =?utf-8?B?cW5ZUHpBZm9JWVpucFJhQU5lVXdEWFNzbWVERmxkbEFZS3pRTkgrYVFqUk10?=
 =?utf-8?B?dTc5NVdoYnhTUk96MGczbEFldkdLTVRjcHR3aXpBZkVBMjdrOENDT0tEMkJC?=
 =?utf-8?B?d1E2THE4N3RZaG1hUlhNdGdFbUpOVmNyeU1YTzBTRUR0SUtPcGttMVNRajg5?=
 =?utf-8?B?ZlFMdkorYmF5VG5IbHJWZ293TWZKYzlLdUt0VlFCUVNLUXZPTG56VUYzaE8r?=
 =?utf-8?B?YjVzNFh4K1NDRFpoYVIzRWZpRStKbVV1K25aZk9WMmJPR2lSUERuSnRUbStL?=
 =?utf-8?B?N294SlBSTGpkZlBSVFhnK3NGSHVHNUQ3Q0NMa0VJcEhWQVdKbjYzVVNOZTVt?=
 =?utf-8?B?YXZabnVCZndBMmNsdzR1ckVxMHlOa3NjZDlhMXlDM3piNDluODVMNmVhVmla?=
 =?utf-8?B?QkxSOWZKL0dVRjE1Y3dNWUtUcnh1VDQ5LzFWTmNoMmZ4d0FCVnl6b3lId293?=
 =?utf-8?B?Vmk2ZjBWNGVsV1Z3ekh4dTN4UmxrM3NKcmtGU29vREp4aElsTUZiNlJvb3Ja?=
 =?utf-8?B?ZEtFalpxbEhtREFQUDVDV29ST2NFemQzRE5xTEtoc0xlY3FoMXZlZ1M2dGtP?=
 =?utf-8?B?RkZPTUl0V0wyTC9odzAwbmNERzB0dCtMeXg0b0xtM2hyWUR3aVFaVHhieG5r?=
 =?utf-8?B?WHFxdHBBRlZKQWMxclZHRXUrSUJBZ3NKcXZRQVoyWi8xdnVqNVArenBXMjUv?=
 =?utf-8?B?cWZPZEc5K0YvVGhnYnJkRXNROGJqZXhVU2FGenc1SG9oVlA4eDhaNVZXd0tB?=
 =?utf-8?B?UVE5ZkJrWkVaa3pUcnRhekMxbGdzZGpyZmcwMTg1OThrbzBsMkhaSlMvTi9C?=
 =?utf-8?B?NnBvbEFsaVBCYWtnL2ZHQWZ3bWZUNXc1MENmVURXQ1A3QUdzVTZ0UVkwSTZp?=
 =?utf-8?B?bXRubDdpQ2NBSEpVZjVTL2ZoNnB6MjF5MlA0UzF2dmdlaUpuUWp2UUhYWU0w?=
 =?utf-8?B?ZGgrVkFmWkVmcE9FNVpPU1dDajlxSTY2ek1aUmpUa3RRYVdhZGFkTXRRVlVh?=
 =?utf-8?B?cXNldjdmSDZ0cUVqVDh0cU4ydjZpQXQ4T2ZXSHdqUFcyd0Y3Y1lyUUs0aUdI?=
 =?utf-8?B?Q2NFeS9JTVI1N3I0OFR0Nnk2ZjBoQ09SenNSWWJUcFByOSs5Nk1iVlFNU1lt?=
 =?utf-8?B?ZTdObUF3UnBvcUJVd2FQaEp4dTdwblB4bVRZa21heTlJSktheUhoWDhSVlRa?=
 =?utf-8?B?OU5NUjFML045YkJ0dXc0YTVCbHhwQ0pkK1MxOG1WL1ZZRHBxSW1QOUhMNlRL?=
 =?utf-8?B?Y2REMHZsN2dFZzNPd2k1U29tY0lqTDU5U1pGZlRzQ0tVakVYL1RDTEY1dlRT?=
 =?utf-8?B?MTNzQzIvbVg3NnpwSFcrcTVrdlB2RStVOHhtRkNsOVNJMTJLSklwZFpScW5s?=
 =?utf-8?B?Mm9zWnpuN244N084R21HYWcxeHZGblhmMWw3UERIYWpoN0tYMTRObFpIa0x0?=
 =?utf-8?B?cFlqNEZjS3pLbGpESWJpTHczdFR0eUtGZll5eXNDbUhRZkVrK09uVmhTam1C?=
 =?utf-8?B?YUQ2RnFMcVBBbnFqdkE3Qkk3dWxubUR4Vng3aFV1cWk1enpqV2FJNjJaRGly?=
 =?utf-8?Q?vtj86xlZf+vAq5xsGPG7YiDgp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd7078d-9fa6-4cf2-36e2-08db36556ec4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 04:14:36.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH/KUNtO5vFrWAHDHqSojqHf/YaBdNR+uFSx04vfwEyjJYLDOqCSEjr8PP0xB5ktez77D9lTL/tSuDecAKM8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
Subject: [virtio-dev] Re: [PATCH v11 05/10] pci: add admin vq registers to virtio over pci



On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> Add new registers to the PCI common configuration structure.
> 
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> dropped Max's S.O.B
> make queue_num not 0 based
> ---
>   content.tex | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 2eb15fa..5057df2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -948,6 +948,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           le64 queue_device;              /* read-write */
>           le16 queue_notify_data;         /* read-only for driver */
>           le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
> +        le16 admin_queue_num;         /* read-only for driver */
>   };
>   \end{lstlisting}
>   
> @@ -1033,6 +1037,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>           This field exists only if VIRTIO_F_RING_RESET has been
>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the first administration virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> +\item[\field{admin_queue_num}]
> +	The device uses this to report the number of the
> +	supported administration virtqueues.
> +	Virtqueues with index
> +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> +	\field{admin_queue_num} - 1) inclusive serve as administration
> +	virtqueues.
> +	The value 0 indicates no supported administration virtqueues.
no supported .. reads odd.
How about,
The value of 0 indicates that administration virtuques are unsupported.

> +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +	negotiated.
>   \end{description}
>   
>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> @@ -1119,6 +1136,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>   were used before the queue reset.
>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>   
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
> +The driver MAY configure less administration virtqueues than
> +supported by the device.
> +
>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>   
>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -7686,6 +7711,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>   
>     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>     administration virtqueues.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport and is reserved for future use for
> +	  devices using other transports (see
> +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> +	and
> +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> +	handling features reserved for future use.
>   
>   \end{description}
>   
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

