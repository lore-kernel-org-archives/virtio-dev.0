Return-Path: <virtio-dev-return-13922-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D08E70706
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:11:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8734E2CAEB
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:11:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78DF798668D
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 10:11:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6CE0F98667E; Thu, 21 Sep 2023 10:11:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F20F98667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 10:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZaBaZcnd54u2ykv8FVPMzhAR2nJIT4JYGD3rt1qIeiauMxJ5jKzf0ElxtxMSXFgDeJNsbTffAjgFBsoQcYwg4ReoeEl5HHjs1ba4HfeixdYdJXv3krZ6D6ND2Ljvd9suYkeVJTygZvOjx5F+ZBitnqptc+Je4hRQ2NTiVBBGysd6EmHv+drxyOHdo8K7zW/kpCgSaGoMhj9FqeW2VYAHy67wDOnF0AJl0HzHZ9zsnfbc6U1frpqsh72UhhmTw+EC5QrKf9nfScSzEsW9hvw4B37DsuGKJlhRKcCf9hDY3c+AxcG2TCm96PHF0sGTecaDEjJ7LnJbKv6OpZG877kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRVQE8lso5JwcI5vmlsR7ytk02/F/HzLSWhvWQHL/Pc=;
 b=QOB87uSkwfE/9MhTwQld6ntzuAtXDHX4rKRKooZo52q8F/9Fo4hTI4H+OMPt1+Xz/IRAYo/x6peaGYS9lgOFcTHmBYHUcf/wONUUCJmgtPz+ja3tK6gbzBJ0q6W7U6k+em/27EOysGHKq9dEFxyL2JYjJ1TxixT2JpojycMqUCSb+WRi++Lhywn+BR/azTWar2q+rhYpWCKkNaN4LKpXjtaP3N98RYhRjAWQRb9j2NwdTUOdiXXhqjhP4+eUlHqXpGaBTNQqP2FQlkbNL6ELlQWKwFj80lpQacVJpqHamhKuYsdrSzYhJlZ3e4GtUDW/WRFJzKmK4xBiOZj7o+trLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Message-ID: <7cf06aec-5787-423a-876e-cd5fb581c225@amd.com>
Date: Thu, 21 Sep 2023 15:41:08 +0530
User-Agent: Mozilla Thunderbird
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Mythri.Pandeshwarakrishna@amd.com" <Mythri.Pandeshwarakrishna@amd.com>,
 "Devaraj.Rangasamy@amd.com" <Devaraj.Rangasamy@amd.com>,
 "Rijo-john.Thomas@amd.com" <Rijo-john.Thomas@amd.com>,
 "Nimesh.Easow@amd.com" <Nimesh.Easow@amd.com>,
 "babulu.ellune@amd.com" <babulu.ellune@amd.com>
References: <d38932451104835ebe23acfc723dc3f0a9f43b98.1693993329.git.JESHWANTHKUMAR.NK@amd.com>
 <PH0PR12MB54810E429F2FE6E18E4D5987DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <PH0PR12MB54810E429F2FE6E18E4D5987DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To DM6PR12MB4564.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8651d217-af40-482f-89f9-08dbba8b1a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VAtoMa4wCI+AtPfmd71P2PFklu1DHgCcvBCqYWFIj2jxwJGHJLQDzXMvH+YcW3PpLW80w4EXo0gQMJjC16Tg0Nr/QBBmT8UG8sKUQ7/1lLajJJcOBl+GCg0MnmfLiu/RMCccvfd9ljuBQsyTgKvAztb+/ThmuSEddyqAmuyH6lL5TdQ5nAXwFgtv0wVl9HEGXIzSVkHeZKX8zl8ZYi8SOj5JQhD7ayHHuiNqhPaKlZHRf0ScUOahJ2kifltDmNcsPmrDhi6/MYHMX7wDhqam9mHFYjEno+OnMTzyxYzOeyACOcGADCGcwURWvMKUvE8hLMwixmtXvg8B+Vv1TO/tF8JKHlB5trskQCKLN+GQsUW1YnmoreN5pINf6no+q14MkgCyyfpRKsgar0g0/Jd/X5Sx5O5P76p4JwfrYMZ1IF0X3jqfSrtydHuIgKW+A3k5qQk23tZW5E5BmxQc5P7QwqEmoshsCo9CmSLgJgoocY/xBRhLNyRd3c/1iHblV7Yv3OBDQU751ELo3Ok4mPZNE/1eyrwXbIy/LJiHYXwlhYw0c1J36nQS2JIfiHk+TozQ+yf8pGCnrA/S2IMuslQDBpkkPIsB6WYnsgpKS8n7wufmA+tCmLpCSG++jMzOmtCAqYRqjV4qlnW2kZc9IvR2ng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4564.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6512007)(6666004)(6506007)(6486002)(53546011)(478600001)(2616005)(2906002)(316002)(54906003)(66946007)(41300700001)(66476007)(66556008)(26005)(8676002)(4326008)(110136005)(5660300002)(8936002)(38100700002)(31696002)(36756003)(86362001)(83380400001)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anJHVEdtT2ZEOEFFWUlwdHc2bFQ5Z1NJNUZTUVc0RUl3WHpZdUdFMEtKY05n?=
 =?utf-8?B?K1EwVUhmRkoxQnBSaG01NEFGbEcyd0E1NnJVRUsxTjQrUVhBM09ucm44UERQ?=
 =?utf-8?B?K0VDTFNhdFBFMUhZaW9OcUkyRm10RjlKMW1uUmJFcmlyMktVSUIrWnpEenR0?=
 =?utf-8?B?Q3hxeE1zK3R4eENVTTFuaVlaNHRobUNoeHZIK1JKN1ljZTErbmNXaW84VmFM?=
 =?utf-8?B?Y3dMZEVibG56ZmRGNVBRY1F6M3hSYUl3bVhtSERpdjE1ZjVIWHVKN3l4MCsx?=
 =?utf-8?B?bFJRNUJwOElhVXNwLzdpWUJ4K2pGckJWTXlXUFJEemE1eENpL1FhTXdqcnJL?=
 =?utf-8?B?N1FPNHF0RFFWTFQ2RDVDaWlndnNVYjZqc3c3R3pBNFB3WEpwYXhMc3orTCts?=
 =?utf-8?B?ZVJqUUgxSzVURTFqekYvVjI4eEVsWjBSS0ttd3E0UTVBWm5MY3lZQjl6TUN3?=
 =?utf-8?B?MTJHY2Q2T2ZMdWxSbkJHcHo2Q3k4YmxxMitqN25lMGtuRjQ2ZGlieDN1TERk?=
 =?utf-8?B?NWJvRFlFQ2hCaW1UZHpIbFhnYmtzLy9IczBUcnJ4R3BacUVPTHZYOUtLS3VX?=
 =?utf-8?B?NUpUWmRJTjduTmhoYWE0R0NFdVYrTTI5clJ1amJFa080WkRCaWhwRDNMeDN6?=
 =?utf-8?B?amVNYkFjR2x5UmpteVk3V0tQcEF3dDVhbE5yTytNVEM4YmVJYmlGY2EzNkVP?=
 =?utf-8?B?c1BUeE1wTmdYS2poeFVmOVpGT2RZMlViK2FRdGNqRHNWSVdyaEFxUW4vQitV?=
 =?utf-8?B?MjRpS01GNHlWeHJCWkVQWDFZb0F3T09YOXl1eHJBQmpCS2NMN3M2d1hrS3dY?=
 =?utf-8?B?ejBQRkg1eDBpZ2wzQ1dRTThsUFArd1NQZHkxWEF5VUI4S1gzOXNnckxUMUk2?=
 =?utf-8?B?TjN0LzFUQ3FKc1V4aUxWQm9NelNKQk5CZlVIOFNxSDVHdUJiL1lGd25PdkUy?=
 =?utf-8?B?TXhrQ2taN0lLcW1ndnhsdkZ1ZE0zNzRWWUROYjZiQ0lIRUhJQ0s1ZlZpN1ZF?=
 =?utf-8?B?MUdhR2V3YTJKdzhOaDBwZSttSHhiZ3Nyd09hRnBmVUpmNFAyNjFVSWlVTnEz?=
 =?utf-8?B?TU5WR1B2WFRqVS9MV1lsQTVZNW94a01SQkJMOC9EV1pwUmQ4RG9mQ1hCamxl?=
 =?utf-8?B?NkhObEFaMmt6VHU1UjROL0VpaStibEtqVW1IeFRTZnJ4TmJVMFRzMmhmaUpN?=
 =?utf-8?B?em45cUNlR2pWZmlCZCs4SGhWcVQxZmExTWU1c3NiSGJCamU1NVZYWnJ2QTkz?=
 =?utf-8?B?S0I5OUZWbjRDeGF5TjUwUW9obVZoMWR3NDZ3QnBpb1NzQmJaNGxqZUxvdE5C?=
 =?utf-8?B?aG9hZFNxbW9aNmVHcEIrdEJ1bE9JWis3SklaZkx6R0JpRkNFUmJrY20rY24v?=
 =?utf-8?B?cFA3dE5mSmpvdk1HTTNsR2dFcXZCQlJabGVYdVgwQUNITWxEMVE4ZVFEQ09m?=
 =?utf-8?B?M09JZWQ0eEQ4YWd1c3JjV214Zkl0WmtwakxIVDNNc09UVUV5dlA3b3Z4aHR1?=
 =?utf-8?B?eUhvSytTTG1jUDNKNzRXdThUbzRWL0dEczZSM1F1dE10VnhqUG0vaHRhb08v?=
 =?utf-8?B?bUVlZXYzUE13N0xiTnQzM1pKVEZkTm1PeUhNYVc0aGhzQ1k0K3p4b1ZwWVJG?=
 =?utf-8?B?WnNKRTVERW80dVFtaDh0MjVPUE8zeTFFV2l3NnB2RjY5ZHU0WkN1YWpGdURG?=
 =?utf-8?B?bWZGMHVBaTc3RnJMQXVRcTRYd3E5RlBxcFU1Q0taTWZHYzZjWXplQXZIc1hj?=
 =?utf-8?B?VDRpT1ZMYUxSWkpIK3BIZFZUZHY0eVhaajBSdkNNZUlyVkhNRVNKYjU5SDBY?=
 =?utf-8?B?WXNQTXl5a0RGVlpuK0VES3d1bkErNVNBdWcxN1U4QjRzMnVkdE55eUV1ck40?=
 =?utf-8?B?bDlLWHRPZ2JGQWZ0WjBwdXIxKzFmeW1jVXI4RElYOExoWFJIL1JKazFCbVJC?=
 =?utf-8?B?Njk2eGRxMVFKcnVQMWFJZ1JPTHowSFFGWHlPRVBKVlVtMEZ4R1ZESFQwMWtD?=
 =?utf-8?B?UVFWV0xiU21kZno3a1VsLzhmSEdiMWs5Q2luMCtPQ0hVblZEYWN1RlVSTnkx?=
 =?utf-8?B?NWdMUU9YejVKMzd2YklEeDFyY3RkQzd5bUhqTzZCUStLUU45TENhdXVOZ1dW?=
 =?utf-8?Q?7gyT+UoB+5Ie1WvzL6tVUKDkv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8651d217-af40-482f-89f9-08dbba8b1a4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 10:11:21.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN1O63JEBG2XcKlS0xhkM98Lb+nF41NClyGoxf0yFbw94vrqFKqkGIA56jjQSJULuO8xH2dj0wEH8sK7yKQdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
Subject: Re: [virtio-dev] [PATCH] virtio-tee: Reserve device ID 46 for TEE
 device


On 20-Sep-23 3:15 PM, Parav Pandit wrote:
> Hi,
>
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
>> Behalf Of jeshwank
>> Sent: Wednesday, September 6, 2023 3:13 PM
>>
>> The virtio-tee device allows guest OS to access the TEE present in host system,
>> to perform secure operations.
>>
>> This patch is to reserve a device ID 46 for virtio-tee device.
>>
> For those who breath TEE its may be obvious thing. 😊
> For me, a humble request,
> can you please expand this patch to contain short description of basic functionality of the TEE device to encompass under this device-id?


Ack, will post a new patch addressing this.

>
>> Signed-off-by: jeshwank <JESHWANTHKUMAR.NK@amd.com>
>> ---
>>   content.tex | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce..644aa4a 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}  \hline
>>   45         &   SPI master \\
>>   \hline
>> +46         &   TEE device \\
>> +\hline
>>   \end{tabular}
>>
>>   Some of the devices above are unspecified by this document,
>> --
>> 2.25.1
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

