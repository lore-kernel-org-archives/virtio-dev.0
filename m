Return-Path: <virtio-dev-return-12393-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFD0C77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:32:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC1C768494
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:32:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF4A198643F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 22:32:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF878983F7A; Mon, 24 Apr 2023 22:32:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC3639863A5;
	Mon, 24 Apr 2023 22:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgvga5ZtvmuFfK9NmcqbMtDu7XZiTz1lHMMO/1bxyotaDHyBiuka9GaIpzgWc5eT9H+I/cF9mRl9sOvhvO6VLj5oqlJgdDO2337z0gbvPU5C1Zb1cUIVGfzoTDOSiar0iac178+c662F4tsLDb8yVRr2y1/cU1X70NYhhQrNUI5+VkfGJ/RHUvqc0J+Jx9kmKWxa6XpXjwRTCQPSMjHFjfjwFNxE/G3hREcFh2nKwVxwJjP8TA2c/53K10EXeMcN4sdA2CWVMXsxzV4Oe4LH6cXpzbPienGlZzRzYJ6THlyen3S5t2+B7HBiuOCUKDIkPJwjdajWXE5ERajD+q8g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9L5e15914t4HUsLRqhn/cEciTP+K1rdFsvNryycnR4=;
 b=IHh4YzCMmMD9aOmfRcC4z2TkayWkzQaLgwKToTWbW0S+zPEaTc5r9ao032FANeGDCX/Jreoup7TVleNaNDww/M9Vj2lH+sgGQGfbIvoYnyiKkLSZR0Myg+lgTxd9KjGv9rRyfDtoAZbk3jBfA8ppteh73DjRk1II+dOPltoSztORzy79nA33qg3asN1ZbZ3DnNs+TA7iHTMIgazRsyfRxnbwVx7aHtqJ3Fbz8LgET9hfdBROH8xqz7N0DPWQ9850kL836VwuSNLHsETdMcK8uxqgjdu2priEF4FYM/S7zx/DnL/YGx875CsN/5u09gZYdwGBaWcjsvRpsR6+fDL12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <916e2320-2874-329a-cf57-6a96644e6ba2@nvidia.com>
Date: Mon, 24 Apr 2023 18:32:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1682354275.git.mst@redhat.com>
 <2334f663f1fd0f11e79235425c6dcf9aa8fa8c1c.1682354275.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <2334f663f1fd0f11e79235425c6dcf9aa8fa8c1c.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:805:de::44) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7154c0c0-941a-4dd4-1dcb-08db4513d7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xnTV6BboS7R0mMFT/wMBPqoEnTiMPh5kWnqlmibP9xofRCqTtGEsWHshyCdwDp2eOro0EXKLWeNrGPwVGQzUOlNjZoerkhdaQhSLY8lHd+d4uPscWTjRlbwbeLXDvyI6eiwgdyN05wnFNMxWj41PYoEuH67nJV50l4Z5hqCvIuDoT045H0hsnAkIS4um3GKNTrUCiZQCC0O7bbhJ5JDoLa+lRBa0AigEOy3OzdpDq4TyIVeAc1OmcO67TTJfvMpZIJ2/i6rTqvDs4WVw7hm9u+U+cGcUlKZsk6vrpg+dyIrQXsb6HVrKjHx3jZrzq/+7K6yLJ9MFRpn9Ig7X8h1wbnQtr4uvg7hy3MHOjEaeM/OTvtuk/VZ8bP+mqz47OF/tL+3foFRYKJ6dyhopfGe7AETmJwu0C45W/ac79IulEc2KN5aS51dLCfcZsGk4fPY5RRn/5raI83ZAM++79lrXWqj0xBqYABEjBv/u8vP+t8GDUkJP2o4S4l6D4dMC8WlKDUyq0ftiMAX8vYNDSsj0vH0TYHOKSu4b+vb6yrdA61gMgbkxHzpfb1yhK6k0EqOPEbg+xicj7EMKHmE23Tb7JoSXUCsFtz7GcMcMof+wfPe6qctYgcMcyhiihwZeSKqBXBW/vXcP2/SP8j/4e33LDKjtm33NHsBNZBaPVzz5vA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(8676002)(6486002)(316002)(41300700001)(4326008)(66476007)(66946007)(66556008)(478600001)(921005)(8936002)(54906003)(7416002)(38100700002)(186003)(83380400001)(53546011)(2616005)(5660300002)(6506007)(26005)(107886003)(6512007)(86362001)(36756003)(31696002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE9GdllzTUZKdDFneGFQbGNZeEtKVEtMYS9IdlpMWDYxVzVtR1ZKaUFQWFhN?=
 =?utf-8?B?bytzdnZjb1kzK1ovdUk3UWlDK05VOFJsYkNQNDVpOGdMYk5IRDhFMy9LVm5H?=
 =?utf-8?B?djRuY3h2b3RhQzVxU1hQcnJBeU9WSnBJYWQ2T3lFZm1UYzJVTlVhald2R3dZ?=
 =?utf-8?B?QS9aSjh3dEd1QjdGYnRCNGR4OVJtakZLaSswTDNaQUxvaU5JWnFSY3NSTm0r?=
 =?utf-8?B?bWhJbWFmeFBCM2FDM3Q4VGhac0l1bmVMOWlnUUZhdmpJbURRWG1wc05UZGlT?=
 =?utf-8?B?TmkvTVpuVVh2b0w3enJkWDJxQXVTRFFLZkVOUElSaGFoRlZFTjFKdjV0WCsv?=
 =?utf-8?B?emZ2TkhrZFNnZGd1S1VTK3BPUmMxTmtadFMzUWJPbHpyaWFFSnFQY043RUVj?=
 =?utf-8?B?cXJVajBMRUFvMnIzQUw3SzY1WURSdU11MFZSdDJCSyt4STlnbE5yRkg0eXNy?=
 =?utf-8?B?MWFiT0xWcUUxY05meVB1RkMremVibFZWMEFQckxpTjF2UTNVMzNSdzl4azRX?=
 =?utf-8?B?SFNER2VhRHlhdFdRUWIvYVFJRDk3VDF0NlBScS9zdHFmejFqTFVmeUNQNUk1?=
 =?utf-8?B?RDBNbi9LSmFCSEpxdTFiZVN5cE0vV2Y1cE5heEYydEJNdHhJY1E4SU01WDNI?=
 =?utf-8?B?d21GbUJMK1Z6YngxTjR1SUpEbHpzaW4zM20xQTFBVlNySjE3ajM3ZXFwQ2JT?=
 =?utf-8?B?SXRPMGJWV2J3TDRkbFNud3U5UmlCbzMvRkROTjc4YklDZEg4aUZ6bnBRSm5Y?=
 =?utf-8?B?Y1V1YWlOWWhDT0kybGdSNWJaU3U0ZERkTmVBRnVSaFdvU0xnMXF2MEhsK2Jo?=
 =?utf-8?B?N3BoalV0UzRlaWRQT1hnOG9RazU1c3pWVWRLOFRoRUF4ZVBjTEdUemdWdEtj?=
 =?utf-8?B?eUpDcDhQVTZsYUFwalZRazVzNW1EdXRuMXVhaXVDOWhNU0xDVFYwYWdXOWZY?=
 =?utf-8?B?U2xwaEF5MkptNjRxVHNacG1ZL3lmRXpxQm55VjhMbHZ5WExWMTlyWEVYanVG?=
 =?utf-8?B?VkdUYURKVHZFUzJaZ3ZzTEdLVmtsaGpGWjF6ZkF5MS9jKzNKQ2piREV5bjBs?=
 =?utf-8?B?d2NCTDNESmNyckxzLytKeFcwY0xmZlAyZXNuN29QS1had2VKVzJDVWZPUGNI?=
 =?utf-8?B?SlVlSUNJOE4zcEFOMGFjN3A4MXgyRWVvVlpIcis5dENWc21WeHZVeDUrLytj?=
 =?utf-8?B?Z0NHSlNjWE1vUFl1V3pSNkVTQzdQeE5ydGs0b0wvMWxQUlM1WGRVMjJ1NlRQ?=
 =?utf-8?B?RVRyR25pRi9iRlA2VDh1U0I1dFVDc2p6dVpDSnhvZVRkdnhLcWRwY2FXVEF6?=
 =?utf-8?B?MjRGeGlodGN4RjNjNHNWbUtGd1pCRFd3c2Z3Q1hkZjVVOTVOZy9LclBVTFYr?=
 =?utf-8?B?SW41VWg4cUgrOHR1emtmaytRbUt4S1lsM1IzWWZuUTNBaDhJQUV1SU1XQmtq?=
 =?utf-8?B?bUtQT1czbDNjb0s3bFM0bFltQXdybE1hSTlUenA5RFZtUnczQzl3MFMvYVMr?=
 =?utf-8?B?K1V2WDBKK3pZM0x1OWVyaHMwZWRzemFUeURrWm95QSt0MVdKZVhrRGtDaC9q?=
 =?utf-8?B?VVFpTWd5OFEzR2hxc2RGZVJsck0rV09iU1FsV3pFeXZmM2VZRHgyM003Y2Vo?=
 =?utf-8?B?QWtldkJXc29IZEthbWRXbGZISExBaVZCUmpaVDJrdzBjWktOeVZoZ2F5KzRI?=
 =?utf-8?B?WDhhQ1pzRlUwNkZVMWFldzdEMFZZYW1lVk55bkZrT1U5Sm9EWGI0Y3ZEWkxv?=
 =?utf-8?B?K2dlMERBeUN4RGR6L09iS0Z2TS9zbnVQVUVpbkVQdXdzZ1JaejBBVE96NmNm?=
 =?utf-8?B?ZG9oalg5SXE0RFB5WllEMGNPbVBjNUhhU21VY2pHeEJEVlZyWFJWZlZGbTI5?=
 =?utf-8?B?d1ZOTnh6QWZrOXQyRkhyK1dCMmppRlM2MXdLWTc4UTZHbDYybGZhZHA4a1Yz?=
 =?utf-8?B?UTl1S1lYTkF3MXg2c3h4dzgvQU1jVnlTOHJxTW5xVW02cldlWDNTZS8ydXZE?=
 =?utf-8?B?MXZCZUZmaVBzSnVYdzFKSTFnMklLVmc1bUNDelJtaGlaTXU2a3lmRnk3NVoy?=
 =?utf-8?B?ZlRJNVZaaFVpRi93eGhQNzFaQWVyaGhvM1VwbkRaS0h5alo3RURQRmtWc0xF?=
 =?utf-8?Q?5ugiOUzASxKB7Rla2Uph7+E0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7154c0c0-941a-4dd4-1dcb-08db4513d7d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:32:53.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFfKcZYXwjxLNHVKZ+2Nv1bt19D8zqgv9DZ0DEUBbmdhidwXHDkmJJNFdmvo0pYWg0dLsb2yguB2kj2ZqIH8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
Subject: [virtio-dev] Re: [PATCH v12 04/10] admin: introduce virtio admin virtqueues



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface used to issue admin commands.
> 
> Currently the virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on:
> virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
> 
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.
> 
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
> The admin virtqueue can be seen as the virtqueue analog to a transport.
> The admin queue thus does nothing device type-specific (net, scsi, etc)
> and instead focuses on transporting the admin commands.
> 
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> ---
> 
> changes since v11:
> 	ack by stefan
> 	queues->enqueues to address comment by parav
> 
> changes since v10:
> 
> explain ordering of commands as suggested by Stefan
> dropped Max's S.O.B
> reword commit log as suggested by David
> minor wording fixes suggested by David
> ---
>   admin.tex   | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   content.tex |  7 +++--
>   2 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/admin.tex b/admin.tex
> index d6042e4..91e0cba 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -182,3 +182,78 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   \field{command_specific_data} and \field{command_specific_result}
>   depends on these structures and is described separately or is
>   implicit in the structure description.
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a transport
> +specific manner.
> +
> +The driver enqueues requests to an arbitrary administration
> +virtqueue, and they are used by the device on that same
> +virtqueue. It is the responsibility of the driver to ensure
> +strict request ordering for commands, because they will be
> +consumed with no order constraints.  For example, if consistency
> +is required then the driver can wait for the processing of a
> +first command by the device to be completed before submitting
> +another command depending on the first one.
> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item The driver submits the command using the \field{struct virtio_admin_cmd}
> +structure using a buffer consisting of two parts: a device-readable one followed by a
> +device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct
> +format structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields
> +depends on the command.
> +
> +However, to ensure forward compatibility
> +\begin{itemize}
> +\item drivers are allowed to submit buffers that are longer
> +than the device expects
> +(that is, longer than the length of
> +\field{opcode} through \field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are
> +unused by the device.
> +\item drivers are allowed to submit buffers that are shorter
> +than what the device expects
> +(that is, shorter than the length of \field{status} through
> +\field{command_specific_result}). This allows the device to maintain
> +a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}
> +
> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the
> +length submitted by the driver, or the length described in this
> +specification, whichever is shorter.  The device silently ignores
> +any data falling outside the shorter of the two lengths. Any
> +missing fields are interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length
> +of the buffer to what it expects and then silently
> +truncates the structure to the used buffer length.
> +The driver silently ignores any data falling outside
> +the used buffer length reported by the device.  Any missing
> +fields are interpreted as set to zero.
> +
> +This simplifies driver and device implementations since the
> +driver/device can simply maintain a single large structure (such
> +as a C structure) for a command and its result. As new versions
> +of the specification are designed, new fields can be added to the
> +tail of a structure, with the driver/device using the full
> +structure without concern for versioning.
> diff --git a/content.tex b/content.tex
> index 04592fb..2eb15fa 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   \begin{description}
>   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>   
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>     feature negotiation mechanisms
>   
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>   \end{description}
>   
>   \begin{note}
> @@ -7684,6 +7684,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>     that the driver can reset a queue individually.
>     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>   
> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> +  administration virtqueues.
> +
>   \end{description}
>   
>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

