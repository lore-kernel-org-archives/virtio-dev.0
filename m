Return-Path: <virtio-dev-return-13320-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242FEEB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:32:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7773F2A8E1
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:32:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FF24986834
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:32:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 63AE698484C; Fri,  7 Jul 2023 15:32:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F208986809;
	Fri,  7 Jul 2023 15:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koO1ZajLLgD1T3OLxTHUWG42juRG4xudywNk66Twmxs9or8bHolZro6hZuswjUhyPrzLLehG4il+AHtYprXeBmlx0uzP92YHuInn4hUen72T2jbxpKeeeFABqN3U22eNHk3RSD/AsXRz7LumXs4D7Ij6W9WXkvpPLeg1D6lqMSAnz7fabd0cfcgWwEyty7JW7H6xJO/EHIl4fxZfOYh+M5ychHjJuKTyQkg8D6f+HEpRnnqhONvUHG5pWOnf5xLMITHcR0vOl1+J2wCYVNIKvtjQ/ErVEPV4BUhly98B5NidDq25Ds0jr9IX8nZrU0NUg9i6YdGoPt8sFtnUYn71Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xopN2tOgBP7zp0HC8FH+6F4MiyeNUHWyaxc/b1PQLNw=;
 b=QLK9Clz2XKw1dufyHxA1G7fbjiQ2vikWe6nlawqAdSgx8EuhYMoXAgPe0poCeHMIziP4uJ3kDrqrp8W4GuV6ArZ+n0WYe/CGl/eWv3Gv8hvMAWYRp5ZQfvovHWdvdJ5+7lhZ/HuDrliHODU6SP+9C2fGvXm/jG0SnfzVW6xTFISml3jRphec8lZDYOQG57lMMCkWUwIRTYqDMMxiY0x1QzeJJQsCfSLKsC1jw46J9V8Wpszx36o6nk/gV8aSLvrW/zx8birYH+3cQKdgGoqoqJ/2b/p+9TVdrxqH8LCUANrYWmMEvfkn8c8P8L/xQKeysTP6WTfGduzYOUkRw5Medw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v12 3/3] admin: Add group member legacy register access
 commands
Thread-Index: AQHZsIa8NKsObqKObke5yxkM3VEKNa+uCmeAgABkxpA=
Date: Fri, 7 Jul 2023 15:32:04 +0000
Message-ID:
 <PH0PR12MB5481EDC9C3F7D397FCF34AC4DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707035401.107855-1-parav@nvidia.com>
 <20230707035401.107855-4-parav@nvidia.com>
 <20230707043229-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230707043229-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7497:EE_
x-ms-office365-filtering-correlation-id: 0b6c001b-9527-4fb4-1bce-08db7eff50e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eywYKQlMLN/0bJF+hSH9di8AvWO74ho2kDOyXYiai6bXsmZc6NgGoRbvjgpEuiaBNacsAAf1jCGmqQsFPIavYsrdzJ26Bz7goiUr2hfhWvXEjCAR5OXbq3I2rreiuxTdC8XU2J1/z7OnrjHmg6aVTTCe51/kYng6v++I0SPdndCZxdrMx3bJxk2GAuafP16bp1FMGpaqhDlK6Rmx0G5Efsr1nAwg8DgxY/HGCXyG1iLxuYgsn1TdnTApBCxuSh4PdhIw+HbqZSGYANnFS+c9j59go5Do7t1aNE2R505mNz36feGecfjf8IVo+3tTcVLGNaPKdLW4a54gDkaKqaoWI4w1MJsNUGMVeh6+HQg7Ndqt2DLFu8vexBxNo+TOYhGediAGajWXfbh/JvbVRtznk8t19pMXo3njUd88FypxX6WkoVnPZxkOsTNGkIKIfcbNrg33H0rObovIozJ3cvhHhyWrPhO9lfGGtXz8RPXmwMze+yi3syAnJPouy9UqcVBBSt0kG1CJUuHrK6GWs7egEmwYIUpBoMxT5SJCmMOgICiQ94RiXEivG17N3YTEQmBXVeo9rHzyRbs5iRNnlbLH9T9+2e8nXHIfo6C9FQRbJM2w9NNjYIJAE+azbmTFURER
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(71200400001)(7696005)(478600001)(83380400001)(86362001)(107886003)(122000001)(66946007)(76116006)(54906003)(4326008)(6916009)(66556008)(66476007)(66446008)(64756008)(38100700002)(6506007)(26005)(186003)(9686003)(52536014)(5660300002)(38070700005)(2906002)(41300700001)(8676002)(8936002)(316002)(55016003)(33656002)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTZOeTJuWUNtRVU5dlRNSXliOHZiMmxxRm8wUm5QcTFkTCt1NEhkYk04WXl1?=
 =?utf-8?B?aUVKU1ViQk93R3RjSkQ2bjNjSUVqejc2TmIxa2FvRWxOeHZKVFZRVkVaN2ZC?=
 =?utf-8?B?WHdOdUZCOXc0QUFWeVpsRG5FMS9HNUFnMEx4eUxobUFTSExtVVdNa0ZWYUZr?=
 =?utf-8?B?azZHZFA5N3VHRVFmaWtoZUtjUWtaSU15RlVTbkRRQXYydmRkUElQamlMYllI?=
 =?utf-8?B?RzhSTUNJdGs3R0lrcVVqb25kV0tBbTQ0cFlUeks0cEpCZ1VsVXBJYWhxdS8r?=
 =?utf-8?B?ZUpjb2JkK2Q4QlYxVXE1TGF6c29kQ0hCUDFOdGRtcEE1ejFMd3NkVHgwNDBZ?=
 =?utf-8?B?d2ZacUZRTXZoUDNyZFdUOVVYWWt5U3lTa0w1WGpxMS9uZXM2cHRaMzcvK3Fj?=
 =?utf-8?B?d0syNzNDZ083anM5Z01OSDA5eGdUcy9tR2hXSC9SbUliSG1QaXhOV0tuSW9l?=
 =?utf-8?B?VDN0VTRCWjE2V0JvdWNDbzJZT0laYXhoMy82VllkNlg5Vm50YlNJUGx0Y0Va?=
 =?utf-8?B?VURTOUljMmp4RDZvcnpXOThDeXZlY1dodEYrNTNCN2o4RkxpQnpHL1J4KzBP?=
 =?utf-8?B?MDlnRVNNNWpYZ0VSby92cTRRd2lKczByZEFKaTBuVTBHODJmeitrc0VMMlIw?=
 =?utf-8?B?MWUrTGJrdVFwL3FmcmNpVDYrUGZvb1BZeXNMYVV6MWVkWnpGV05pSXJvMEgw?=
 =?utf-8?B?QmVXeUpXd21qNVg3aEluRFdPRUZWeXN5bXJXa0IxRVVEampXMnNSNnkyT05z?=
 =?utf-8?B?R3dEVW9tTlZ1VG5wbTd2S3VhVDNRL1MzcEppNVRZZTRSWlNHWGtyMWg0dGZB?=
 =?utf-8?B?ZlN4ZEJFaGdqVWE4RG9iL2hSd3VaU2ZHVkF6WjY5K3ZoU2NOd3QxWEdGa2g1?=
 =?utf-8?B?ZEZGUFQ0QU9VWWhxUUxIZ1NJWGNXNUZ4UmNDeXVaUXFOVmJReHFDVnRXalFX?=
 =?utf-8?B?MDQ3a0t1TGVSTjVuT1BYVWt2NTgvTnZLUWpRMDI0RCtyUkVQTVFyYkx0cVpT?=
 =?utf-8?B?LzRRU0xJQUp1cXljNGdDaU5IZFZxTFJ6QThMNjVnZHhSdGJ2MVAzTE5ZT1VU?=
 =?utf-8?B?MXR0VjU1OXBqTkhOeHpsaXh1V1N6QlJhZ0pmaGxjcjFQNTNGaHJIT1IrSTN1?=
 =?utf-8?B?RmhXbnVpNDQyRlkzODJBQ2ZrYzU5VXdwZmZIdk5PMWhaTi9FaUtPaStJbDR4?=
 =?utf-8?B?VTdhdlRleEtLN0ZvdmFMaG5JaXdZTlZLTUQzeStJUE9MT1JxOS83QkZzZG91?=
 =?utf-8?B?Y0JzVFlpMXJWMWkwNFkrNmtrLzBTSW1lcUdtekdHZC9hMXg1Y2hhZkRjcEFD?=
 =?utf-8?B?blNxUTJPcGVURXFBV2hPanp4ajY0T3pCcHI3bEVaazN6Y0ROVEZPaHFnVnls?=
 =?utf-8?B?SndyZ0tLSy96aU4xRURvQzBiMlJNUXNhUzZwSm1WNGQ4cVprd3pVUGFtbzVE?=
 =?utf-8?B?eG9zYnlGYkhxRHVoNnJZN1AycWp0WWhVSVU3UnZEOGpybEZWdmlqTlFmNUVM?=
 =?utf-8?B?b21qTUFPRERhcXBKSWRZR01sVjNud2Q0dlFtaUwwRHRpUm5yTEY2d2hlU0pG?=
 =?utf-8?B?Rk5CcmNkT1dyOTE4WWdJYWZLOTRNdzRkZVpNRjBnYUJTQkdYVTB5THJyOEtj?=
 =?utf-8?B?NlZHc2MzZWMzOWRXOEtjUHhuV3NpOThHMDg1aUxLRGszUkF6OXozQzRmWmNQ?=
 =?utf-8?B?L1JiRFUrb0NpZ2FTVWc2c2pFd3BjbGlDYXFsWU1lSjVBRllkeUZiVXBUV1E0?=
 =?utf-8?B?SHRzRWdUSU5EMWFSVzIyaFhNc0xCSnRaU2lvVFI3a2tuZjY5VC8zRE1IN3lI?=
 =?utf-8?B?YXVodFhIbWdDTDFTL0xMVkNHN1ZHUExUdFRoWXdPZTNlaW1GM1FoVCtMUU5M?=
 =?utf-8?B?Y3RYUkIyenNkUFFucjhIMTR6L1RaQW9VMlR1dk45Q3hDMnJicE9oVS9kaDFr?=
 =?utf-8?B?YitaSk5nbGRXRk9HcjRVaUJ5RktBTHU4YmdOQW10bFhnMGE2aG1FSE5Danhr?=
 =?utf-8?B?M0xnc3BmNVJIOEVZcGxTSlV6amFSMEVMb2RFd2cxMVBza0w3b2ErY0RtV1Fm?=
 =?utf-8?B?T0Ixc1NHN3I3NE9QUVhvRnZVT2lsVnBPaS9LWWc3UThLTWh1RFJTMHVlYldj?=
 =?utf-8?Q?q73A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c001b-9527-4fb4-1bce-08db7eff50e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 15:32:04.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 122UKZ5bO4C1fSDX2TxZ0ZdmI28dcHc6zAgFob6d4GEjl/zLhYEKpswTiLW5TmXQ267KlHzRUIyosc7LPJZA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
Subject: [virtio-dev] RE: [PATCH v12 3/3] admin: Add group member legacy register access
 commands

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgNywgMjAyMyA1OjMxIEFNDQoNCg0KPiBvayBnZXR0aW5nIHRoZXJlLiBtb3N0bHkg
bm90aWZpY2F0aW9uIG5lZWRzIGEgYml0IG1vcmUgd29yayBidXQgaXQncyBjbG9zZS4NCg0KRml4
ZWQgYWxsIHRoZSBjb21tZW50cyBpbiB2MTMuDQpUaGFua3MuDQoNCg==

