Return-Path: <virtio-dev-return-12386-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C576C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:35:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 31E5E29FD4
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C095698643F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:35:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4109798643D; Mon, 24 Apr 2023 21:35:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 749F69863A5;
	Mon, 24 Apr 2023 21:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDQ/cJA8Hf076zgUm25IzLlLlCPExNZ/CCJq5/VkRQZsyNyMNgq9w9QbYIjdhulE7+iaxX0vDE0Nh3wdpAq1dNWfRiwdMeSk+/8KkzQRc3adzzBWY1aWYbjdvJ2JCduBhQw8TY24eC21ukUj7LFzAtwat3xEkqN4nhiZ133Pj6vd1cHrpmu+jfGl1tFFJoLOqvuChd0XnExptexfecSSh+46jGR+O+atlPNau/YzX1vuB25QrmnEk77sE+2NayJnxMaJE1Vpr9Atidqhwp8jR5kTOGTxssC7jAGZwFy4jxKQBaurnOJNy1i08zh1kk5Rh6vCbGMlHt+Ye6QEvhNwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26BjHzbeYkoD0ZT+ucL/PO3OmJj1w0yCxBL1ZOABNME=;
 b=glqS5oL/wyJ1HdHWQr9DatpiZGgOv5BUWp1nKzdqVEWNTHxC3inVI4sgnzGv1MGIo4AVV5NaA1MyE2/J87cABIbVjGX+a4l/ZX2YrZYnuCArwpXd+6bCgNIyiuN3IOX4GV8wPAqYN5t4bOJaWXHjEPlZOoVWnu7fMb0+L8gyeMNoR/VPPgIIzVuvRLhhrAOsuoukmo76F1dFtvNiL9/R8UUU0BUeAe/EstZJaDeFJZaEvkjG5uPNipmj2VmyWV/L0EoA+Ao25NDTnQtoiJJIy88gvKrvzFNur967mmKAFXhyEceh7YCKoM7qXi1mb/HHSbrkIJIpLZmgip86yUPGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <96083133-31eb-1c6e-e057-94dc97173f06@nvidia.com>
Date: Mon, 24 Apr 2023 17:34:18 -0400
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
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:8:2a::11) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: d1735c32-4be0-458b-45b5-08db450bac07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RD4Y/wPQR6ISPiaor9ET3NdTXxEyuosziCyRcodjMyqLt4BuoHDgFPd4cNnMd63uud9uKjUzlHFdcz/rzLdCHHvUhCYXi43A18DVy+CH3TssSeVELvqcpE1WrIlCShunqg8gT+YBjaPMiICVYFe4lOQifYYGnGcGamDZPp6ReEHtEBxihXipxOmW898ODHn1Q2BI1G8xRRzU6BJlqixGTT2YBaSVxQAeoX78JTI1qqkox8G3jSLzytYUKSAoOGiYCm938V0GO0ZNOqN5m7Mz2siq0/OP2QrpUBdFEiJokwYo4S0OSAocREw7XGv3pF5QUwrtel88YGHW03Brh+xviE57lGvuK7Go2+SCHlaUqqUpvmmo61TBGpmgqPu/yroC+nNW2icJXxVjVg8kAhQX7ZzzWcbdcfzRuj72gLuX6upYE1kO9uzZOKloHTq834B281r4EwzsXvRZdB9BjYlBX6DMRfidgrFqa4zSmt8iaAZjVnHhesnRvFthc7TmBtGrH3oEOcRdL4pRkETTRKqWXd5SCkmFWG5J4ONVSi6XCtEyQ/FsE8wITHGpzsOwRS8PNCa8+C8bG18uDRiqYeg9KsZ7GGkN9eGbk9kGvHb/aF0RovV1Kc3EyLReKmlXBaa3pXLxZ7Ij1oTr2sdsBL49tDr0PfU5JDQMFlEayBvfcMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(7416002)(8676002)(5660300002)(8936002)(41300700001)(36756003)(31696002)(86362001)(921005)(186003)(6512007)(26005)(107886003)(53546011)(38100700002)(478600001)(6486002)(6666004)(83380400001)(31686004)(2616005)(6506007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWhCZFk3bUhsVi85YTMwTURidmZPeXNDUFhCQUF2Q0d0NFhhRENQTmNoZ1Bj?=
 =?utf-8?B?WlZCSXlsQlFCY0J0UUVOOHZyaUJ0aEtqSzNSRXZ4ZVdYYnQrWlFGREhoODBB?=
 =?utf-8?B?SU5KdW14dmd0NEVqdzdVVU9SWkNDUzk1YXd4SnB2eUNJV3pEVXluUG91aHU5?=
 =?utf-8?B?MEVyYWdxMXN3bUdneHFndkFzaEhaaGovTVAremRzYzJDTlZMWkR4VHZwM0cw?=
 =?utf-8?B?UDNqbzkrRklDT3RTcVlPbmlKQ3RXUTNtVlVBclcxRFkvdytTQnQ2WUo0bnJU?=
 =?utf-8?B?cDBTbnRqVTN5K01lZ0l1azVscGpXQmx5Nm4rdnc3Z0NGMWh6ZFdySmdtbFRt?=
 =?utf-8?B?VVRla3ZPNnBER3JIZFhrb2dsNVpPSW1LNEVpQTRzTlFWdWRNSGVLYVlLMzda?=
 =?utf-8?B?eW1qNUxWdmljTlJWczdlek1CS0JNbGN4ajJWM3VHeDVLeldvRkpwZ0UvcHBr?=
 =?utf-8?B?Mkc1WHR6VDhzM1c5YVh6Q2I1RHFVeWpXVlFIODJDQlRoWWU0bFFtREFDaGk0?=
 =?utf-8?B?dm53WWZuQ0t0OGxQdXNLckg3SFJOak1SRFhxOUpNaWxoOEhJM29JQkpVWndl?=
 =?utf-8?B?YXlSU3htbDNSdUlnVHNjNGlTa1JZVERDSXc0eU9HemRDYzFPbzhZY3Uza05J?=
 =?utf-8?B?SzNiQVAwMnJ2Tk1YTDU0bWVuNkpER0lnWGVnN0FtRStNK05SSXVYK3UxZTlZ?=
 =?utf-8?B?RTd4TGFuS2t3NmRtcTNqOFBtcFFOdGVpTnNnSnZZdkU5WmtQcDV2MmJ1Wkhs?=
 =?utf-8?B?TFJoQnprR0lOZWpWOWJnZ0t4T24vbEd6SkpWcFlhQVRmK2puc0c2WEluaEhk?=
 =?utf-8?B?SDdUUzV0UW9YWllwNHJVMXlkVHZaV211MUlwMzBISlBVNUZXclBGc2UvOVZy?=
 =?utf-8?B?ZlNTSW1ReU1JVWZ1c2JCN0tpbTkvdm5DdGo1RFk4Z3g5RG56VmJ6TDNFblNQ?=
 =?utf-8?B?RDVLNXd2RC9IeFdaUXNkR0hsc1ZlYmpaSTRqb2V4SVRrS3hNc3F2NXhiaXhs?=
 =?utf-8?B?aEg0RWZJMU9BbE1BYlZEL3VCakJ1OEUxbnRIN2tpRy9jQUh2RzJ3OGh0WmR5?=
 =?utf-8?B?b1o2cnJFSkhFdEs3YldWQWx1WE9CQ081anRaaTk4SFJhL2VKNUNTY1IvMW95?=
 =?utf-8?B?UysxK1lOZjhRZFFHMVo2WnpQbzZOWC9UOWxpeXJiUVRIb0pVcWZwRFV5cXJm?=
 =?utf-8?B?WlhJOG1rT3hTVzBqSlFPdzFnUGpVK1JpQXNXMUFCSUVEMTRDaE16MVhQVzRD?=
 =?utf-8?B?TS9Mcnd5b3dJVEFwQ3BFOVhZRmlTekt6VjFGRFhPU2xpMk9SV1hXQW0yYWEv?=
 =?utf-8?B?VkVJdTdySi80MjIrTlg0MUxGUFpoZlhFMnRLQ3VNMndnZys2ajhBZk95b3ho?=
 =?utf-8?B?aEJqSDAxVnFDTEhraWNGTHk5ZjV2SnFkWnR1L29aV0IzN1pQRE14b3N0ZVV3?=
 =?utf-8?B?ZElxU0VVUklLNGpQV015bGhYRU4xTGZ0ZEVvUFZzMFlWZzdGanhrWjZ5citj?=
 =?utf-8?B?WHBENEpNM2xQb011MjFqbjY3cHlUOHFDM3oxNFdJZmt6eUoveklTWDJEZUpK?=
 =?utf-8?B?bm9tcHVudFVFaTlXNk41TEtTSGtqa08zNmhDbGM2NVMwYWI5TFdZQjdvMkxl?=
 =?utf-8?B?V095TTlmL1k2ZkJvdGIzMDhJa1M4VjNQYVRlallualJrbzNrcytzcGZXOWky?=
 =?utf-8?B?RDN1d0Y4NldiaUc3MHJzaDJuaXJxTzVZNTFZUTVGek1jL3dsRkVyb0ZXVHRF?=
 =?utf-8?B?d2pBd3B5TmJDT0hFcXJTUjhwVy9ycjBMWE9CNC8rK2ZCdUhXZVlRbTg2djNL?=
 =?utf-8?B?R1RRMHZGRWdwbFZHU1dHL05kZjNqcTZxU3BmRFVtcnVlNVp5WEtBSHhGRmtl?=
 =?utf-8?B?em9tZDA5ekZDZXZmVnZOa1BsTmVEOFNpNXBQdnR1dy9PaWdPZ1JuM1hIMXVE?=
 =?utf-8?B?MXRIZzc3NGdYbm5uZDF2NXBMcDJVOUpScXlXWEx0ck1PWGpXSnkyYURzcnZN?=
 =?utf-8?B?N3B0L0RJM2k3VWgvWHpRTlhkR2N0eE40ak9lSFFEVWVnaE82M2REb3kwVFpW?=
 =?utf-8?B?bHNXdW5EVEp2em9zb2tCNTZBaXRSQ3I2U3RXSTYwOFZnRVRpTFhtVGVTa1hX?=
 =?utf-8?Q?43xwUoeQi7X4Ea+HBKv61shTM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1735c32-4be0-458b-45b5-08db450bac07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:34:23.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAiczbLnaU93wpX1qXk+7Ba72T/K7oL1OeQKgdfg7+27d3UCYkxDc//1Ayem9LT77HFN1BATm+/lQrU/WhyYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
Subject: [virtio-dev] Re: [PATCH v12 00/10] Introduce device group and device management



On 4/24/2023 12:44 PM, Michael S. Tsirkin wrote:
> comments on previous one have all been minor, so I hope
> this means we are close to merging this.
> 
> Change log:
> 
> since 11:
> 	one "breaking" change in response to stefan's comment:
> 	in patch 5, num_queues has been specified not to include admin
> 	queues: just regular ones.
+1.
This will enable pci driver to dynamically enable the AQ without 
depending on upper layer driver.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

