Return-Path: <virtio-dev-return-11920-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A9CC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2461E2B01F
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 052F19863FE
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:35:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DE8159863DE; Mon,  3 Apr 2023 17:35:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2E759863DF;
	Mon,  3 Apr 2023 17:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYHOYN2X7Z8Ne1I1TLQ4mNq6/oLqIkJO9Px5lu+KL0lotsv4GS8zJkUE40tYMasfuPei6AoF5ODg+tL4r+zvkrRsw8yXY3R5ZdzZ28glKJWpW503wR/1egLxYVAh2l1q1erOvXeGG7Hsl9C1zQmMYxAaMT+aii4iHbaNgme0Pg7GszBvl1F4s1sgdDx2afUI/EuKzW1M0cRGjVlAbX3OPBcXZn3KxoVnBgXWDUiqrpqIZ26XTKP9N9ao8IzGTkLJ94ORg8LSUbGE+SsQrX0889n1RR8sAJ6y7m0wRuuGYeFnGOaoH2YMO/vH+qkWjDT44SpRxuCS3FSjLAKP0INUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/GBBm44Xyn1aLD6gk3N0rJ+VgS/h2hFD8UlKbS7zK0=;
 b=jGcAeu1VaCtgoVHi3++f1Gw5bM90KEAfRPjfjof3iIetw3sUX4xXmmWxxNm7mLNAHmC5XpJem9XF+BG0kCm+CSu4y/K0vd5xC09SNKwzv/MITjNqpOt7TTWeJrDApdfqxdPeWAtObkAtidu/jN2k2h9h9jf/ewOyfV3679zuhVYijSZ9K2ujHmZa5ZemJbcTTr/pyFfmIEoxEh9dolGnM2U3Ckcuo7ESDkYo/zjJOeFXxHoa8LqCW+CyPr2pAlHKDS8zPvLwX4nHIzctvbkNHlRos9RhKuqe2WJj9wBMWcs/PPLYCPsI97HcZGqM+c6w+P14MrOQxHslA9qO3yeWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <e48d2980-2a23-29e4-0628-cd812f324985@nvidia.com>
Date: Mon, 3 Apr 2023 13:35:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <20230403113130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815BFAFF4BC17F37864B8FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403132442-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230403132442-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a48367-9381-4054-ea6b-08db3469c2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aD6AeCO3zJt/JBd9aSRb/0Aus8/TyV+p5WCVrPzYwkTbSdrxUYgV5Qz3ZXxyc6rJ2kz2+GZVqjch2Ubl6q5CPfifB2A0M+wHqy45Nu/fFhwtyhwWg8wBQ1s32CGszA1Y0JTWo7QUJ2eLoGg6dCEtdne1q/JOfHV+ecyOkFYFkYCtmg+aTMF6kmIjIzY1J/3UQ0eE5YxdtdM4OW8IroXXgCNnoLUhL4qPsTk4Ne5/ByiekMLemxzyN6DZmDEUQAjRAi5WgYDp4HpF1RyLaHV8iKlTh3tmEYS3taIuQz56vethq5HrF+3wBXCIlnz80N31ymXKnDz6QBO1OXSwXJ/iCtZlsu4OLfl19LK5299m0INHy62CVFPwVKcH80FayiIQ9aC4zaDoLY2YASNn+/SckblK/TuzdJKYFy7QkEAoFVWKN5s5n77QGgPeyDfRK/v+lEtKb+/r/LZMHyhNFVuEGv9hWQ6NiyR7pxs8wSL/unyDPdH00WkEaavbOLIDfEFsbBMiEMPQ9gragbUS9EHyqhzbk+PgYz1MtPYgWuf4K78xyeQLZIBdFRgMByI46c1Maex1hWCBP5WzGY+UuimsjE2C7Eb0HtQgaXRssgHTVSI7FqPb9OwFTTXWpeZb/xTKfbpJM+a73ScMnVBsgKQ91Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(6916009)(66556008)(66946007)(66476007)(8676002)(478600001)(316002)(54906003)(8936002)(5660300002)(38100700002)(41300700001)(4326008)(53546011)(186003)(2616005)(6486002)(107886003)(6666004)(6506007)(6512007)(26005)(86362001)(31696002)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDc4SWRZWWdZTUU0cHZKVkpJTGJRZW05cTd1MS9zZU5zZnBoZzdmSjM4WEdY?=
 =?utf-8?B?ekVvK3JkWG5lR0dkdEVtaFRFNStHNlhlTldnVEFFWDU2bXI4UFhua3dzdTIw?=
 =?utf-8?B?N0pidmNYbUJJMGNLa2JsWWErQ1BseDF6YWdLRkdWYU1NeFpLSXFiRCtQdDA5?=
 =?utf-8?B?WjFtME9SdGNqWGp5aWxkdnEzcm94a0JJRG10S0RlU0JKRHZQb1lQS2lNdG1Y?=
 =?utf-8?B?ZTkzZCtsOXlNdmtabVlXSjBNNjUxZGxtZGVZbm1rZU1hZ1hzVG01Q1RGTEpm?=
 =?utf-8?B?WVFNM1c2NnlJTWd0V0VGcFA0RlJtQ3VuaUk0Mmx1djBOSHNYUWs1MUI0dG05?=
 =?utf-8?B?Y1ErYlBFQ1NnZ2FqaFlxSllWcHRJN0JUaFBmbFNRZzZUUUIxR2xmNE9NbmRC?=
 =?utf-8?B?cWNUR2pPeEk3cGlWdXpObjlNR0NoNU5maWVmQldJQ0VDVHNlOTU2VlNScDBt?=
 =?utf-8?B?MmYyTjd1Z2JIOWtROTd3bVhLdm5laHk2aGFzNHNqdXF6clVBUzEraTQzREdw?=
 =?utf-8?B?VHdWMTFpOUdhVE1KWktKZXN5cllzbENRQnVObU10bTBmbGo4ZEZHd25iZ003?=
 =?utf-8?B?U0tKaDVYcXRkVkFIdTkwdXE5b1JCOFk0S1Yyb0NvUkVib1doZE1BdzNLUC8x?=
 =?utf-8?B?cFc3SmEwU0IrMjJOcy9sYXlzR0I4M0FBcmo5WlRZSmZEdTFNeXNOWGxleDJw?=
 =?utf-8?B?V0NVVkFhYkswbnFsSzZaUUhYNGZQK1FxdmFiV3dXOWZNaFNjN2IwcWVpRWZn?=
 =?utf-8?B?L1U3dkZhNXdma0pSeHBzV1RwM3NDSURpbFVkTkYwS0VNaFVwN2xNQXo0b0JL?=
 =?utf-8?B?L3BNV0FKYjFGWndCaUwrNG9wUkVlaHFoZHFDbURZYmNQaHM1akFaa2Rtc1Z1?=
 =?utf-8?B?cmVLWCtTMlU4WnprSDFxZngxb2NXTlBROGpvYUVxeHI4cW0wZTNaR3MvSGpt?=
 =?utf-8?B?dVIwaE1ERU0xdERvL1JBbUUvY0pLN0I1SWJtK1RHeUVaQ2ozUnE4enBsUWZN?=
 =?utf-8?B?eW9IYk45ajY0M282OW85bHRTNEdaQ3lrSUIxSE1DVzVESWJVeWtzckZ2R2pt?=
 =?utf-8?B?TGpyU1YyZGhaVGU5eWh5MWt3YzNMVnFVMVlWc0JTRW1rNnd1NjBvTjA3c29y?=
 =?utf-8?B?eitUMFp6MnRjSy9HM3RTVUFwRUxXUnA4bTgxUHFlZ0pHNmVxbFFINFhkcFhP?=
 =?utf-8?B?WFdLNkR0anVMMnprQTR3bHhEb0gvR2gyd2dvMzR1bmtGOEFXZmRnN2I1b3lp?=
 =?utf-8?B?bll6UnpHL0taL2swSHg1M2ZPQ0xNZy9uQ05kQnZMOVpwQVBjNUcrZzltaGdP?=
 =?utf-8?B?dFZ5d1YwaW5ueTJmTnhxaUJ2emxEWWU2blk0MEtOWGdweGxFU0xUcVA1NXNI?=
 =?utf-8?B?aWFDdUtJS01HRzNMSjNNbWtKcTViNXg4aTBkUDJYRXRxR1A0YmVmU0M0YndY?=
 =?utf-8?B?Rm9XZWVXOStDYTdpRkgwblB1QkxTWjlVWEZzNFYraWE3MmlVbXJCME44dFlI?=
 =?utf-8?B?empWdVlTbTJmRE9DUVRwa2grd1VRWTBwYVVxVVFkOTYvLzNhcUpJSXRNb2tp?=
 =?utf-8?B?YkRHSEFhYndseUVSQTVFTUpuOSsvSnRBVi9PaHhiQlRVV2dnY1BNU2xoY0xi?=
 =?utf-8?B?Z3lFT1pKMWR6cDRrVXNZeUo1THRpcmcvNHhxNWNQWlpFbkRRZVAwZjAzd3Vo?=
 =?utf-8?B?aEVDV0Vma2gyNzRiVnNhZm9QRk83YUJnS21jeVFQSkkxQ2pkWFBTck1FYUhy?=
 =?utf-8?B?VXV1TzRGczJ4b3YzT1FRaDk5MGY0TUNGZ3J4Y1RXRVhwTXRnOVdRT0liU1Vq?=
 =?utf-8?B?eUw4NTlxdEF1RTJmYmphSWE5SVptZEswaHZORmpNYzJqaXhzSm52L2VxVUtn?=
 =?utf-8?B?MXRTNjZRTVZJWUx3eFlYNDBVR2pZYm5rc1NUVzljUG0xR3F1WUJpTklneHpn?=
 =?utf-8?B?QmlJclJpdWdHT04rZGJ0UzN6OWw2ZXREYW9WcVFCQmtCZWtuTWtpM1AyMzFT?=
 =?utf-8?B?VGZqMHFlRFlXM2JZSW0xS0lwNEZDOTRBNlJpakRiaktDRjhrNHRFWk43WHVn?=
 =?utf-8?B?cEU2STViY2tPMW1sbEphSHFlTnJZaElGSE1VSlZJRldZR1pvcGJWR1d5WVh1?=
 =?utf-8?Q?lk7hsZpWRcuvh60EsF2mPbb2N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a48367-9381-4054-ea6b-08db3469c2a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 17:35:04.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qjhE+p1dxgjv6rGBWR1QQuC4mgs7OkPIbuyf1hs7o06cnSy0i9oFSZslJDdvNoyNEdY/rCDniPl7HCQO41nEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device



On 4/3/2023 1:28 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 03:47:56PM +0000, Parav Pandit wrote:
>>
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, April 3, 2023 11:34 AM
>>
>>> Another is that we can actually work around legacy bugs in the hypervisor. For
>>> example, atomicity and alignment bugs do not exist under DMA. Consider MAC
>>> field, writeable in legacy.  Problem this write is not atomic, so there is a window
>>> where MAC is corrupted.  If you do MMIO then you just have to copy this bug.
>>> If you do DMA then hypervisor can buffer all of MAC and send to device in one
>>> go.
>> I am familiar with this bug.
>> Users feedback that we received so far has kernels with driver support that uses CVQ for setting the mac address on legacy device.
>> So, it may help but not super important.
>>
>> Also, if I recollect correctly, the mac address is configuring bit early in if-scripts sequence before bringing up the interface.
>> So, haven't seen real issue around it.
> 
> It's an example, there are other bugs in legacy interfaces.
> 
The intent is to provide backward compatibility to the legacy interface, 
and not really fixing the legacy interface in itself as it may break the 
legacy itself.

> Take inability to decline feature negotiation as an example.
Legacy driver would do this anyway. It would expect certain flow to work 
that has been worked for it when it was working over previous sw-hypervisor.

Hypervisor attempting to fail what was working before will not help.

> With transport vq we can fail at transport level and
> hypervisor can decide what to do, such as stopping guest or
> unplugging device, etc.
> 

> So something like a vq would be a step up. I would like to
> understand the performance angle though. What you describe
> is pretty bad.
> 
Do you mean latency is bad or the description?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

