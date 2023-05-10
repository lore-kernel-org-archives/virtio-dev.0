Return-Path: <virtio-dev-return-12629-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59131C77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:08:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A9A2C77E2
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:08:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A24EB9866E5
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:08:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 971BE986590; Wed, 10 May 2023 16:08:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D3E4986591;
	Wed, 10 May 2023 16:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyLkw8wDMbGz7+i72LixZpe6rmTCs5w85hfW4p/eCBx/28wvVnAkGhvN7QQjyb8Zm2Dxv8PZH5eCY3FS/DIuP/8xGQPmqHrbZQ/lMvphlvq9AF+UTfAzBgDI5nRwsCpPV+Ig0I4XR04XxL+QYhw4sPgIEjxqEK5Z1b59zB+mENkRm5MfkVz0yq4PN//dGV5JMIp3AdrUbe2BCG2uc2eOaR205pYKfa8qGpsquyAHfPghH5I+8baFP90fBl9zjYk0V0z4dCqqbS5Lynzu70Jx5qptOyJlE/03H2RJ4dlqhn+zOKzewS4QO9sGNTjE3dL1TFA/qdH71RvijeDFgzsWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONxe9JSzkN8MaKxC+G8HnfXfDuBzMu72kKrQx2xJhlA=;
 b=fDoLNHo7EMjTBZMvhqec1O0WtUKXApis1jADFGkqoDUOhY89hNUQaTPtSlYOhbgyJZgHpZGIeI8FYSeLNXaePloEtEfOXv1POh7KUxkLsWLxSTPSmLgcKXwbSsmtv+/Tby9OqS4SY9Up/xwO/I/7rozEun885hj5bCQl4eFnABkRX+HeDCW97NnxtdKRI40pt/+vCzdFzSze2aalzx27uA+0gTA8omYGUK9fj1i+Der1Mi7wlKSJag52pvIyrJNgzTmBza2P247wdgqI3IBA76RMvcEgfUyHM0BlIwGwAphtT7XPrm4cs0L2+fDgeXCRYbhU8l6feqO4m8qsUb4xeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <03c8f7ca-8235-a5a7-5367-b6fd59ad0447@nvidia.com>
Date: Wed, 10 May 2023 12:07:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <CACGkMEuqGtJP3vXoHrXOBgvPz3woo900+U9kYX1xZnM5h_qXWg@mail.gmail.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEuqGtJP3vXoHrXOBgvPz3woo900+U9kYX1xZnM5h_qXWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::28) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 939bd5a1-779b-4257-2841-08db5170bb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yu0kxnDOr4hO+SJ5jrFLbEj/o+vbsQiB0O3sb20n3lnymbp49k+n3+CxeSOYVCagBsKoOTN3q5Ec3Yiag98MlSOpTIv5M8EKIMCM9Ep52dealwMNhavnh9otqC2b3QtYOu65a/P+NbxQ9jaCz6PdE1vGFDlDSH9rJeROjJuxGSdw1CVCT8ek2M4EJhM0fI6DaZbIq0ma7sU99AYy/L0g1E+kz6oXTSiTITowVn9pUIVZvYV3GVi5nqVor735d/yne6pdx78pab6k+nXNkiuxppFmbN6+VOHDVy2n2P/xATUsnsjfSN61FJqEFxsf78TDhH86LMxc0toVpYsJ0jgGklAW/Q7idN/ERJTfI9OXCE9aLZkMBaKi6r5vJVDXZjCs5fEiHfa2/Di2eDuLRmrJCPScn5YKsvGaoaHyxfnLqaSZIo6jMieBXfv+l+LsJj/ZGtibmqyw/0fQ+B6zU4TMNGSCq9wBOw88WYRSHnyOXGdgqTOntU+JHVcUkt+aOvrj0esCwq8U8JQZRBfCiXvRyWv2AMFzc0KI8M6Z9al4I5Q99znoZ0MGKSf+ORBekS2nY1a0767iUb0sJ0YWiw/9TkdieWIR/dcw6FT/CTGT70yofyOlt/MRVeULNRLeC+T9pkFA+IisWrcetwzShbJXvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(83380400001)(186003)(2616005)(2906002)(4744005)(38100700002)(36756003)(31696002)(86362001)(5660300002)(8676002)(8936002)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(107886003)(41300700001)(6486002)(6666004)(316002)(31686004)(54906003)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkYzVmdHRExCbkFXNThQNXVWZHRTSUI5Umw0ZlA0SEpEd3pZUi9tQUNjUTFS?=
 =?utf-8?B?NHZQL1JNaC9FQ3dyQjJKRVpEU3M4TXZndGdOOTNOSWM2RURiTnZrT0xwclF0?=
 =?utf-8?B?RGNjdEEwd01RcVFjOXd4M0lGSEVjMThieGtxamJHU1N5eE91dmRTZHFucEx3?=
 =?utf-8?B?TkE0cmVsai9ieXFyYkY5WUIwTTI0dnRka25saFZ3cGtRY3BVcVJPNmxWOTg1?=
 =?utf-8?B?MHNDOXJSSHlOMUJReFRnUDBjNS9UZkhwanJpdllRS0k3djdvbFFCa0xmRkNs?=
 =?utf-8?B?b0tNN1dvMC9aSW5GMVRMVDhWQk03S1RtQTNxbS8wWmE5QkRFL3ViY0tZV1Bo?=
 =?utf-8?B?MTI5dWNub0VvM3NFZTR3VWU3RWhoUUU4dkpyUDJWdkJKdjFWalM1Z0drRWVq?=
 =?utf-8?B?ai9kcTZ1YUxIOFFHUm13UE5XUDdET3pnM0laRlhnV1E1NUVhcEp1bHpTdVc0?=
 =?utf-8?B?SEVyUTBoNVEzS2JwOFhSeitISXhHdWZuOUNUUlkvdXpLYlVCNlpXSDRTMXA3?=
 =?utf-8?B?b3Y1eGhPRU9Cek1hWHZ1M3RNUEUzclpTemU1SUk5MldRNXA0QUVtdG9tT2FP?=
 =?utf-8?B?ZXFObE91azZXZ0UvR1Q4YlY3NFpsZjlJczlJcE9DSXRVb1ByQnkwWDBLWWhR?=
 =?utf-8?B?Z0hlZ2xvZTY2NWZMNTIxQUpmWUxkZFBLako5NTV6Q2VTVTdlVWFqOFZFR016?=
 =?utf-8?B?UkM4S3dmY0hjcEFxV1Rhd1FLOEFISEZ3MjFucVVyK2JVUDFocGo2My8vL29z?=
 =?utf-8?B?U0hFUFI0aldxaEtCTWI0dWl6YmFvTllVYUs1SS9RQXpvaDBtbkgxcXhHV3pl?=
 =?utf-8?B?N0pERUwwSXZuL3JEREp5UXd3cWxDSmg5Y0hwTWNxaS9oVHBHTFhpV3M0djlS?=
 =?utf-8?B?QmhsZ2JPV3NuR2MrSWhVb3A0L0E3NWs1SXlwVlNFQ1g0SXlSRjVIaG1JRndl?=
 =?utf-8?B?akh6M29SMmI5YU9yZFcvcUZHNm4rUnBxd0hZUFozSkZtcmdxclI3UWxPeXlP?=
 =?utf-8?B?dGtraGplRC93bFpBTG1yQnpGMDh4Tkd3NXovRDdnbU92VmlHb3NWWW56UW1I?=
 =?utf-8?B?THpaUHkyMlhYV1Zsd25JZkswL29MYzBGUEd2SWJna20wdU84aXQ1NkpDSjY5?=
 =?utf-8?B?aEdFNVJoK1VBQyt6cnpqL1hyV1IyVDdGZVJrcDRpQzNtbVB4SEVYOWhocDRa?=
 =?utf-8?B?ajJidkhPREhZRWtGMlIwZVZQVVU1V3pNaEVNZ28rRlhVQXhOTm15bXh5aUdt?=
 =?utf-8?B?UmFmT2tWSEgzQmF4dlNoK1FCQ2NOZ1dnaHZadmhPcHZLU2VVWWoyVG5NNmlC?=
 =?utf-8?B?elRkOU5GRlY5eG1reVhnUjhTdk1nZW1sbVlPMFNtd0x3M3lDaHdlcTFHMFBT?=
 =?utf-8?B?MDBvUUhEZTN6K0FydS9ERG02VXNVeEVSL0lwNVdCTG1aeXhCTkt2c2xOalVE?=
 =?utf-8?B?T0hXRUMyOFNReGdHVFo0cjlUS0FPUktkQXdpL1phdFllUlI3RmpqTWVMTXM3?=
 =?utf-8?B?UHBaRDk4b0o2ejFyUUJvZGZLMGIvSUhjaC9xQm84cjljQjQ2dmN5K0QxVUNp?=
 =?utf-8?B?WTV1ejVpTkJqc2RmRFMvTzR5WElzRUJnZ0Q0ZFQ5dURCeXM3SnBjSUVrRTJ3?=
 =?utf-8?B?TG9iWjhuYjRuS2c3MHZ1QWxQOFdmQTM4VnpXZDhCTDA1YTVEWGc1WGhBV01G?=
 =?utf-8?B?aGJTM0RQUnJMdE5Jdmd6T2lFbDRRWlR0RmMzbE5aUHJienI2a3JROUVKL1V4?=
 =?utf-8?B?eDBOYStNMU1rdTF4VUZQSU5uTWhiS2doRjJXUlh6TCszSUpOZDA1OGpWcndK?=
 =?utf-8?B?M1B0YTdSM3cvWTRHVFhNVTNhMDE5QmdXOThPYTVqT3NYRXNkSm1aanJBbXlW?=
 =?utf-8?B?MWtMcGlNSVJtQVdOY3VYbTM5Z0J5QVhIbVZ5OElNMnR2UHA5a1dzMndhV1Vw?=
 =?utf-8?B?S254NFp4Zy9mdGh6WkxPaTN4cHd6bnROZ1RjYUM0SUx0NE5YR2hLM2t5OTg4?=
 =?utf-8?B?VTRoY2xiUHRmR01SdDVhU3pqSmVyUFl4Mm0rMGR0bUJMN2JNb09ENDk4eEg4?=
 =?utf-8?B?WUsxWWgwQVVGM25ScTgvWWFpaXFhRE9uUFhlekFLcmZtSVBNVUprRDZrc0dO?=
 =?utf-8?B?ODllVXhWcFRubUxzRGxuQ3hHZ1RUWlB6VGhlS09DQXJtdW90WDFNUkpOY0Yx?=
 =?utf-8?Q?FbB45KN7MYehOLK0IQvtsoEmbYufki1nvK+c97Z4t48v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939bd5a1-779b-4257-2841-08db5170bb16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 16:08:02.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azEZEULxJ4CZhUb34Q1Wt1UfbTmfTKwnhsvbqA0QKma2AS8+Xg6FM/acLyKE4Hdhat2wQeWYKAUIobI9oPyfwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/10/2023 12:22 AM, Jason Wang wrote:
> On Wed, May 10, 2023 at 11:51 AM Jason Wang <jasowang@redhat.com> wrote:

> 
> Just to make sure we are at the same page.
> 
> 1) if the hardware has configq and we need to make it work for current
> virtio-pci driver, hypervisor needs to trap guest PCI access and
> translate it to configq command. This means the hypervisor needs to
> hide the configq from guests. In this case the configq needs a
> dedicated DMA address which is what PASID can help.

> 2) if the hardware can report the device states, unless we want to
> migrate L2 guest, hypervisor should hide it from L1, so PASID is
> required to isolate the DMA for guest traffic and device state.

A configq negotiates + discovers new fields for the PCI PF, VF, SF/SIOV 
devices over PCIe or other transports.
So no need to hide/mediate for hw based devices, like cvq and like data vqs.

For vdpa kind of use case it can work like cvq mediation, which I 
believe is happening without PASID today.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

